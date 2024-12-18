//
//  VPNManager.swift
//  Runner
//
//  Created by mostafa omar on 13/02/2024.
//

import Foundation
import SystemConfiguration
import NetworkExtension
import Security
import UIKit
public class VPNManager: NSObject, FlutterStreamHandler {
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
    func getVpnStatusString(_ status: StatusConnectionVPN) -> String {
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
         default:
            return "Offline"
        }
    }

    @objc func vpnStatusDidChange(_ notification: Notification) {
        GetStatus { status, lastMcc, dateConnection in
            let vpnStatusString = self.getVpnStatusString(status)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = VPNConstants.dateFormat

            var dateString: String?
            if let connectedDate = dateConnection {
                dateString = dateFormatter.string(from: connectedDate)
            }

            print(vpnStatusString);
            let data: [String: Any] = ["status": vpnStatusString, "lastMcc": lastMcc, "dateConnection": dateString]
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
            stopVPN (flutterResult: result){ success in
                result(success)
            }
        case "getStatus":
            GetStatus { status, lastMcc, dateConnection in
                let vpnStatusString = self.getVpnStatusString(status)
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = VPNConstants.dateFormat

                var dateString: String?
                if let connectedDate = dateConnection {
                    dateString = dateFormatter.string(from: connectedDate)
                }
                result(["status": vpnStatusString, "lastMcc": lastMcc, "dateConnection": dateString ])
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
    
    
    public enum StatusConnectionVPN {
        case Offline
        case Online
        case Connecting
        case Stopped
    }
    private let nameTun = VPNConstants.serviceName
    
    
    
    
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
                        flutterResult(FlutterError(code: VPNConstants.startTunnelError, message: errorMessage, details: nil))
                    }
                }
            }
        }
    }

    private let vpnMan = NEVPNManager.shared()
    private var lastConnectionStatus : StatusConnectionVPN = .Stopped
    public var LastConnectionStatus : StatusConnectionVPN {
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
    
    
    public func GetStatus(listener: @escaping (_ status: StatusConnectionVPN, _ last_mcc: Int, _ dateConnection: Date?) -> Void) {
        self.vpnMan.loadFromPreferences { (error : Error?) in
            let p = self.getBaseProtocol()
            self.vpnMan.protocolConfiguration = p
            self.vpnMan.localizedDescription = self.nameTun
            self.vpnMan.isEnabled = true
            self.lastConnectionStatus = self.vpnMan.connection.status == NEVPNStatus.connected ? StatusConnectionVPN.Online : StatusConnectionVPN.Offline
            let vpnStatus = self.vpnMan.connection.status
            let status: StatusConnectionVPN
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
    
    public func stopVPN (flutterResult: @escaping FlutterResult,callback: @escaping (_ status: Bool) -> Void) -> Void {
        self.vpnMan.loadFromPreferences { (error : Error?) in
            let p = self.getBaseProtocol()
            self.vpnMan.protocolConfiguration = p
            self.vpnMan.localizedDescription = self.nameTun
            self.vpnMan.isEnabled = true
            LibSettings.mcc = 0
            do {
                try self.vpnMan.connection.stopVPNTunnel ()
                flutterResult(VPNConstants.connectionSuccessful)
                callback (true)
            } catch let error {
                flutterResult(FlutterError(code: VPNConstants.startTunnelError, message: "Error stoping Tun-VPN Connection \(error.localizedDescription)", details: nil))
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
        
        let kcs = KeychainHelper();
        kcs.save(key: VPNConstants.sharedSecretKey, value: sharedSecret)
        kcs.save(key: VPNConstants.passwordKey, value: password)
        p.sharedSecretReference = kcs.load(key: VPNConstants.sharedSecretKey)
        p.passwordReference = kcs.load(key: VPNConstants.passwordKey)
        
        self.vpnMan.protocolConfiguration = p
        self.vpnMan.localizedDescription = self.nameTun
        self.vpnMan.isEnabled = true
        print(serverAddress)
        
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
    
private enum VPNConstants {
    static let serviceName = "VPN Candodream"
    static let sharedSecretKey = "SHARED"
    static let passwordKey = "VPN_PASSWORD"
    static let dateFormat = "yyyy-MM-dd HH:mm:ss"
    static let connectionSuccessful = "VPN configuration successful"
    static let startTunnelError = "START_TUNNEL_ERROR"
}
    public class KeychainHelper: NSObject {
        
        // Identifiers
        let serviceIdentifier = "MySerivice"
        let userAccount = "authenticatedUser"
        let accessGroup = "MySerivice"
        
        // Arguments for the keychain queries
        var kSecAttrAccessGroupSwift = NSString(format: kSecClass)
        
        public let kSecClassValue = kSecClass as CFString
        let kSecAttrAccountValue = kSecAttrAccount as CFString
        let kSecValueDataValue = kSecValueData as CFString
        let kSecClassGenericPasswordValue = kSecClassGenericPassword as CFString
        let kSecAttrServiceValue = kSecAttrService as CFString
        let kSecMatchLimitValue = kSecMatchLimit as CFString
        let kSecReturnDataValue = kSecReturnData as CFString
        let kSecMatchLimitOneValue = kSecMatchLimitOne as CFString
        let kSecAttrGenericValue = kSecAttrGeneric as CFString
        let kSecAttrAccessibleValue = kSecAttrAccessible as CFString
        
        func save(key:String, value:String) {
            let keyData: Data = key.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
            let valueData: Data = value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
            
            let keychainQuery = NSMutableDictionary();
            keychainQuery[kSecClassValue as! NSCopying] = kSecClassGenericPasswordValue
            keychainQuery[kSecAttrGenericValue as! NSCopying] = keyData
            keychainQuery[kSecAttrAccountValue as! NSCopying] = keyData
            keychainQuery[kSecAttrServiceValue as! NSCopying] = VPNConstants.serviceName
            keychainQuery[kSecAttrAccessibleValue as! NSCopying] = kSecAttrAccessibleAlwaysThisDeviceOnly
            keychainQuery[kSecValueData as! NSCopying] = valueData;
            // Delete any existing items
            SecItemDelete(keychainQuery as CFDictionary)
            SecItemAdd(keychainQuery as CFDictionary, nil)
        }
        
        func load(key: String)->Data {
            
            let keyData: Data = key.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)!
            let keychainQuery = NSMutableDictionary();
            keychainQuery[kSecClassValue as! NSCopying] = kSecClassGenericPasswordValue
            keychainQuery[kSecAttrGenericValue as! NSCopying] = keyData
            keychainQuery[kSecAttrAccountValue as! NSCopying] = keyData
            keychainQuery[kSecAttrServiceValue as! NSCopying] = VPNConstants.serviceName
            keychainQuery[kSecAttrAccessibleValue as! NSCopying] = kSecAttrAccessibleAlwaysThisDeviceOnly
            keychainQuery[kSecMatchLimit] = kSecMatchLimitOne
            keychainQuery[kSecReturnPersistentRef] = kCFBooleanTrue
            
            var result: AnyObject?
            let status = withUnsafeMutablePointer(to: &result) { SecItemCopyMatching(keychainQuery, UnsafeMutablePointer($0)) }
            
            
            if status == errSecSuccess {
                if let data = result as! NSData? {
                    if let value = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) {
                    }
                    return data as Data;
                }
            }
            return "".data(using: .utf8)!;
        }
    }
    

        




