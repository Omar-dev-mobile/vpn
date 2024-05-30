//
//  VPLibDDD.swift
//  Runner
//
//  Created by mostafa omar on 13/02/2024.
//

import Foundation
import SystemConfiguration
import NetworkExtension
import Security
import FlutterMacOS

public class VPLibDDD: NSObject, FlutterStreamHandler {
    var eventSink: FlutterEventSink?
    private var vpnStatusObservation: NSKeyValueObservation?
    
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.eventSink = events
        print("onListen event")
        if vpnStatusObservation == nil {
            NotificationCenter.default.addObserver(self, selector: #selector(vpnStatusDidChange(_:)), name: NSNotification.Name.NEVPNStatusDidChange, object: nil)
        }
        return nil
    }
    func getVpnStatusString(_ status: StatusConnection) -> String {
        print("Swift code")
        print(status)
        switch status {
        case .Online:
            return "Online"
        case .Offline:
            return "Offline"
        case .Connecting:
            return "Connecting"
        case .Stopped:
            return "Stopped"
        }
    }

    @objc func vpnStatusDidChange(_ notification: Notification) {
        print(" onListen onListen onListen onListen onListen v onListenonListen")
        GetStatus { status, lastMcc, dateConnection in
            let vpnStatusString = self.getVpnStatusString(status)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

            var dateString: String?
            if let connectedDate = dateConnection {
                dateString = dateFormatter.string(from: connectedDate)
            }

            print(vpnStatusString);
            let data: [String: Any] = ["status": vpnStatusString, "lastMcc": lastMcc, "dateConnection": dateString ?? ""]
            self.eventSink?(data)
        }
        
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.eventSink = nil
        self.stopObservingVPNStatus()
        return nil
    }
    private func stopObservingVPNStatus() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.NEVPNStatusDidChange, object: nil)

        }
   

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "configureVPN":
            if let args = call.arguments as? [String: Any],
               let username = args["username"] as? String,
               let serverAddress = args["serverAddress"] as? String,
               let sharedSecret = args["sharedSecret"] as? String,
               let password = args["password"] as? String {
                // Call your configureVPN function here
                configureVPN(username: username, serverAddress: serverAddress, sharedSecret: sharedSecret, password: password,flutterResult: result)
            } else {
                result(FlutterError(code: "INVALID_ARGUMENTS", message: "Invalid arguments", details: nil))
            }
        case "stopTun":
            StopTun (flutterResult: result){ success in
                result(success)
            }
        case "getStatus":
            GetStatus { status, lastMcc, dateConnection in
                let vpnStatusString = self.getVpnStatusString(status)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

                var dateString: String?
                if let connectedDate = dateConnection {
                    dateString = dateFormatter.string(from: connectedDate)
                }
                result(["status": vpnStatusString, "lastMcc": lastMcc, "dateConnection": dateString ?? "" ])
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
  
    public enum StatusInitTun {
        case Creating
        case Failed
        case NotAllowedConfig
        case Success
    }
    
    
    public enum StatusConnection {
        case Offline
        case Online
        case Connecting
        case Stopped
    }
    private let nameTun = "VPN Line"
    public var initTunProcessing : ((StatusInitTun, String?) -> ())?
    
    
    private var tunSaveHandler: (Error?, @escaping FlutterResult) -> Void {
        return { (error: Error?, flutterResult: @escaping FlutterResult) in
            if let error = error {
                LibSettings.mcc = 0
                flutterResult(FlutterError(code: "SAVE_CONFIG_ERROR", message: "Could not save VPN Configurations", details: error.localizedDescription))
            } else {
                self.vpnMan.loadFromPreferences { loadError in
                    if let loadError = loadError {
                        let errorMessage = "Error loading preferences: \(loadError.localizedDescription)"
                        flutterResult(FlutterError(code: "LOAD_CONFIG_ERROR", message: errorMessage, details: nil))
                        return
                    }
                    let p = self.getBaseProtocol()
                    self.vpnMan.protocolConfiguration = p
                    self.vpnMan.localizedDescription = self.nameTun
                    self.vpnMan.isEnabled = true
                    
                    do {
                        try self.vpnMan.connection.startVPNTunnel ()
                    } catch let startError {
                        LibSettings.mcc = 0
                        let errorMessage = "Error starting Tun-VPN Connection: \(startError.localizedDescription)"
                        flutterResult(FlutterError(code: "START_TUNNEL_ERROR", message: errorMessage, details: nil))
                    }
                }
            }
        }
    }

    private let vpnMan = NEVPNManager.shared()
    private var lastConnectionStatus : StatusConnection = .Stopped
    public var LastConnectionStatus : StatusConnection {
        get {
            return lastConnectionStatus
        }
    }
    private func getBaseProtocol () -> NEVPNProtocolIPSec {
        let proto = NEVPNProtocolIPSec ()
        proto.useExtendedAuthentication = true
        proto.disconnectOnSleep = false
        
        return proto
    }
    
    
    public func GetStatus(listener: @escaping (_ status: StatusConnection, _ last_mcc: Int, _ dateConnection: Date?) -> Void) {
        self.vpnMan.loadFromPreferences { (error : Error?) in
            let p = self.getBaseProtocol()
            self.vpnMan.protocolConfiguration = p
            self.vpnMan.localizedDescription = self.nameTun
            self.vpnMan.isEnabled = true
            self.lastConnectionStatus = self.vpnMan.connection.status == NEVPNStatus.connected ? StatusConnection.Online : StatusConnection.Offline
            let vpnStatus = self.vpnMan.connection.status
            let status: StatusConnection
            switch vpnStatus {
            case .connected:
                status = .Online
            case .connecting, .reasserting:
                status = .Connecting
            case .disconnected:
                status = .Stopped
            default:
                status = .Offline
            }
            self.lastConnectionStatus = status;
            
            listener(status, LibSettings.mcc, self.vpnMan.connection.connectedDate)
        }
    }
    
    public func StopTun (flutterResult: @escaping FlutterResult,callback: @escaping (_ status: Bool) -> Void) -> Void {
        self.vpnMan.loadFromPreferences { (error : Error?) in
            let p = self.getBaseProtocol()
            self.vpnMan.protocolConfiguration = p
            self.vpnMan.localizedDescription = self.nameTun
            self.vpnMan.isEnabled = true
            LibSettings.mcc = 0
            do {
                try self.vpnMan.connection.stopVPNTunnel ()
                flutterResult("VPN configuration successful")
                callback (true)
            } catch let error {
                flutterResult(FlutterError(code: "START_TUNNEL_ERROR", message: "Error stoping Tun-VPN Connection \(error.localizedDescription)", details: nil))
                callback (false)
            }
        }
    }
    
    
    var perAppManager = NETunnelProviderManager()

    public func configureVPN(username: String, serverAddress: String, sharedSecret: String, password: String, flutterResult: @escaping FlutterResult) {

        
        let p : NEVPNProtocolIPSec = self.getBaseProtocol()
        p.username = username
        p.serverAddress = serverAddress;
        
        p.authenticationMethod = NEVPNIKEAuthenticationMethod.sharedSecret
        
        let kcs = KeychainService();
        let success = kcs.save(key: "VPN_PASSWORD", value: password)
        if !success {
            print("Failed to save VPN_PASSWORD")
            // Handle the error, e.g., by showing an error message to the user or retrying
        }

        let sharedSecretSaved = kcs.save(key: "SHARED_SECRET", value: sharedSecret)
        if !sharedSecretSaved {
            print("Failed to save SHARED_SECRET")
            // Handle the error similarly
        }


        let persistentRefPassword = kcs.loadPersistentRef(forKey: "VPN_PASSWORD")
        let persistentRefSharedSecret = kcs.loadPersistentRef(forKey: "SHARED_SECRET")
        p.sharedSecretReference = persistentRefSharedSecret
        p.passwordReference = persistentRefPassword

        // Optional: Debugging output to check if references are loaded
        print("Shared Secret Reference: \(String(describing: persistentRefSharedSecret))")
        print("Password Reference: \(String(describing: persistentRefPassword))")

        
        
        self.vpnMan.protocolConfiguration = p
        self.vpnMan.localizedDescription = self.nameTun
        self.vpnMan.isEnabled = true
        print(serverAddress)
        print(sharedSecret)
        print(password)
        
//        let onDemandRule = NEOnDemandRuleEvaluateConnection()
//
//        let instagram = NEEvaluateConnectionRule(matchDomains: ["*.instagram.com"],
//                                                                 andAction: NEEvaluateConnectionRuleAction.connectIfNeeded)
//
//        instagram.probeURL = URL(string: "https://www.instagram.com")
//        let messenger = NEEvaluateConnectionRule(matchDomains: ["*.messenger.com"],
//                                                                 andAction: NEEvaluateConnectionRuleAction.connectIfNeeded)
//
//        messenger.probeURL = URL(string: "https://www.messenger.com")
//
//        let facebook = NEEvaluateConnectionRule(matchDomains: ["*.facebook.com"],
//                                                                 andAction: NEEvaluateConnectionRuleAction.connectIfNeeded)
//        facebook.probeURL = URL(string: "https://www.facebook.com")
//        onDemandRule.connectionRules = [instagram,facebook,messenger]
//        onDemandRule.interfaceTypeMatch = NEOnDemandRuleInterfaceType.any
//        onDemandRule.probeURL?.stopAccessingSecurityScopedResource()
//        self.vpnMan.onDemandRules = [onDemandRule]
//
//
//
//
//
//
//        self.vpnMan.isOnDemandEnabled = true
        
        
        self.vpnMan.saveToPreferences { [flutterResult] error in
                self.tunSaveHandler(error, flutterResult)
            }
        return
        
    }
}
 
    private final class LibSettings {
        private static let nameMccSettings = "mcc_request";
        
        static var mcc : Int! {
            
            get {
                let defaultsSettings = UserDefaults.standard
                return defaultsSettings.integer (forKey: nameMccSettings)
            }
            
            set {
                let defaultsSettings = UserDefaults.standard
                if newValue != nil {
                    defaultsSettings.set (newValue, forKey: nameMccSettings)
                }
            }
            
        }
    }
    
import Security

class KeychainService {
    func save(key: String, value: String) -> Bool {
        let data = Data(value.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: "YourVPNService",
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        ]

        // Delete any existing item with the same key
        SecItemDelete(query as CFDictionary)

        // Add new item to the keychain
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }

    func loadPersistentRef(forKey key: String) -> Data? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecAttrService as String: "YourVPNService",
            kSecReturnPersistentRef as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        if status == errSecSuccess {
            return item as? Data
        } else {
            print("Failed to load persistent ref with status: \(status)")
            return nil
        }
    }
}
