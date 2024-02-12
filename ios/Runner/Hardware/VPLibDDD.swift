import Foundation
import SystemConfiguration
import NetworkExtension
import Security
import UIKit

public class VPLibDDD {
    
    public static var ID_SERVER_DEFAULT = "1"
    public static var ID_TARIF_DEFAULT = "1"
    
    public init () {
        
    }

    public static let VersLib = "0.01";

    private let nameTun = "TunDDD"

     public enum StatusLoadConfig {
         case Progress
         case EndProcess
         case ErrorProgress
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
     }
     
     private struct DataTun {
         let user : String
         let pasw: String
         let srv: String
         let key: String
     }
    
    private var lastConnectionStatus : StatusConnection = .Offline
    
    public var LastConnectionStatus : StatusConnection {
        get {
            return lastConnectionStatus
        }
    }
     
    private var InfoTun : DataTun?
    private var accVpnInfo : vpn_info?

    private var currentUserInfo : user_info?
    private var lastErrorFromServer : String?
    
    var LastError : String? {
        get {
            return lastErrorFromServer
        }
    }
    
    public var IsLoadedConfig : Bool {
        return (InfoTun != nil && InfoTun!.user != "")
    }
    
    public func resetData () {
        UserInfo = nil
        AccInfoVpn = nil
    }
    
    var UserInfo : user_info? {
        get {
            currentUserInfo = UserSettingsStorage.GetLastUserInfo ()
            return currentUserInfo
        }
        set {
            currentUserInfo = newValue
            UserSettingsStorage.SetLastUserInfo (lastUsrInfo: newValue)
        }
    }
    
    //впн учетка установленная в телефон и сохраненная в системе secure key
    var ActiveInfoVpn : vpn_info? {
        get {
            return currentActiveVpnInfo ?? nil
        }
    }
    
    private var currentActiveVpnInfo : vpn_info? {
        set {
            UserSettingsStorage.SetActiveVpnServer (lastActiveServer: newValue)
        }
        get {
            return UserSettingsStorage.GetActiveServer ()
        }
    }
    
    //впн учетка полученная с сервера
    var AccInfoVpn : vpn_info? {
        get {
            accVpnInfo = UserSettingsStorage.GetServer ()
            return accVpnInfo
        }
        set {
            accVpnInfo = newValue
            UserSettingsStorage.SetVpnServer (lastServer: newValue)
        }
    }
     
     ///Статус загрузки данных для открытия и подключения туннеля
     ///
     /// - Notes:
     ///  Для метода LoadConfig
     ///
     public var loadConfigProcessing : (((StatusLoadConfig, NetVariables.ErrorCodes?), String?) -> ())?
     
     ///Статус создания и открытия туннеля
     ///
     /// - Notes:
     ///  Для метода CommitConfig
     ///
     public var initTunProcessing : ((StatusInitTun, String?) -> ())?
     
    public func LoadConfig (uid_device: String, mcc_device: Int, serverId: String) -> Void {
         LibSettings.mcc = mcc_device
         DispatchQueue.global().async {
             let packet = GetProfilePacket (uid: uid_device, mcc: mcc_device, idServer: serverId);
             let se = URLSession (configuration: URLSessionConfiguration.default);
             self.loadConfigProcessing? ((StatusLoadConfig.Progress, nil), nil);
             HelperHTTP.Request(typeRequest: HelperHTTP.TypeHTTP.POST , sessionUrl: se, packet: packet, callback: self.callbackNet (errorCode:errorString:));
         }
     }
     
     /// Асинхронный метод получения статуса связанного с бибилиотекой туннеля.
     ///
     /// - Parameter callback: результат получения статуса туннеля
    public func GetStatus (callback: @escaping (_ status: StatusConnection, _ last_mcc : Int, _ dateConnection : Date?) -> Void) {
         self.vpnMan.loadFromPreferences { (error : Error?) in
             let p = self.getBaseProtocol()
             self.vpnMan.protocolConfiguration = p
             self.vpnMan.localizedDescription = self.nameTun
             self.vpnMan.isEnabled = true
             self.lastConnectionStatus = self.vpnMan.connection.status == NEVPNStatus.connected ? StatusConnection.Online : StatusConnection.Offline
             callback (self.lastConnectionStatus, LibSettings.mcc, self.vpnMan.connection.connectedDate)
         }
     }
    
    func getIPAddress() -> String? {
        var address : String?

        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }

        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee

            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {

                // Check interface name:
                // wifi = ["en0"]
                // wired = ["en2", "en3", "en4"]
                // cellular = ["pdp_ip0","pdp_ip1","pdp_ip2","pdp_ip3"]
                
                let name = String(cString: interface.ifa_name)
                if  name == "en0" || name == "en2" || name == "en3" || name == "en4" || name == "pdp_ip0" || name == "pdp_ip1" || name == "pdp_ip2" || name == "pdp_ip3" {

                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)

        return address
    }
     
     private func getBaseProtocol () -> NEVPNProtocolIPSec {
         let proto = NEVPNProtocolIPSec ()
         proto.useExtendedAuthentication = true
         proto.disconnectOnSleep = false
         
         //If this property is true when the includeAllNetworks property is false, the system scopes the included routes to the VPN and the excluded routes to the current primary network interface. This property supersedes the system routing table and scoping operations by apps.
         //If you set both the enforceRoutes and excludeLocalNetworks properties to true, the system excludes network connections to hosts on the local network.
         //NETransparentProxyManager doesn’t support this property. The default value for this property is false.
         //proto.enforceRoutes
         
         //true - exclude apple push notification (but only when the includeAllNetworks property is also true)
         //proto.excludeAPNs (The default value for this property is true)
         
         //true -  Wi-Fi Calling, MMS, SMS, and Visual Voicemail exclude (but only when the includeAllNetworks property is also true)
         //proto.excludeCellularServices (The default value for this property is true)
         
         //true - AirPlay, AirDrop и CarPlay not for tunnel (but only when the includeAllNetworks or enforceRoutes property is also true)
         //proto.excludeLocalNetworks (The default value for this property is false in macOS and true in iOS.)
         
         //true - all non system service for tunnel (the default value for this property is false)
         //proto.includeAllNetworks (The default value for this property is false)
         
         //let r = NEPacketTunnelProvider.init()
         return proto
     }
     
     private let vpnMan = NEVPNManager.shared()
     
     private var tunSaveHandler: (Error?) -> Void { return
     { (error:Error?) in
         if (error != nil) {
             LibSettings.mcc = 0
             self.currentActiveVpnInfo = nil
             LogManager.Error ("Could not save VPN Configurations")
             self.initTunProcessing?(StatusInitTun.NotAllowedConfig, "Could not save config")
             return
         } else {
            self.vpnMan.loadFromPreferences { (error : Error?) in
                     let p = self.getBaseProtocol()
                     self.vpnMan.protocolConfiguration = p
                     self.vpnMan.localizedDescription = self.nameTun
                     self.vpnMan.isEnabled = true
                     do {
                        try self.vpnMan.connection.startVPNTunnel ()
                         self.initTunProcessing?(StatusInitTun.Success, nil)
                     } catch let error {
                        LibSettings.mcc = 0
                        LogManager.Error ("Error starting Tun-VPN Connection \(error.localizedDescription)");
                        self.initTunProcessing?(StatusInitTun.Failed, "Error starting connection \(error.localizedDescription)")
                     }
                }
        }
    }}
     
     private var tunLoadHandler: (Error?) -> Void { return
         { (error:Error?) in
             if ((error) != nil) {
                 LibSettings.mcc = 0
                 self.currentActiveVpnInfo = nil
                 LogManager.Error ("Could not load VPN Configurations")
                 self.initTunProcessing?(StatusInitTun.Failed, "Could not load configuration: \(error?.localizedDescription)")
                 return;
             }
             
             let p : NEVPNProtocolIPSec = self.getBaseProtocol()
             p.username = self.InfoTun?.user
             p.serverAddress = self.InfoTun?.srv;
             p.authenticationMethod = NEVPNIKEAuthenticationMethod.sharedSecret

             let kcs = KeychainService();
             kcs.save(key: "SHARED", value: self.InfoTun!.key)
             kcs.save(key: "VPN_PASSWORD", value: self.InfoTun!.pasw)
             p.sharedSecretReference = kcs.load(key: "SHARED")
             p.passwordReference = kcs.load(key: "VPN_PASSWORD")
                 
             self.vpnMan.protocolConfiguration = p
             self.vpnMan.localizedDescription = self.nameTun
             self.vpnMan.isEnabled = true
             
             //let onDemandRule1 = NEOnDemandRuleConnect()
             //onDemandRule1.interfaceTypeMatch = .any
             //self.vpnMan.onDemandRules = [onDemandRule1]
             //self.vpnMan.isOnDemandEnabled = true
             
             self.currentActiveVpnInfo = self.AccInfoVpn
             
             //LogManager.Debug("currentActiveVpnInfo ip=\(self.InfoTun?.srv) usr=\(self.InfoTun?.user) psw=\( self.InfoTun?.pasw) k=\(self.InfoTun?.key)")
             
             self.vpnMan.saveToPreferences (completionHandler: self.tunSaveHandler)
         } }

    
    public var IsDemoApp : Bool {
        if let it = InfoTun {
            if it.user == "user-demo" {
                return true
            }
            return false
        }
        return true
    }
    
     ///Создание и открытие туннеля по данным загруженным из метода LoadConfig.
     ///Статус выполнения работы отслеживать в initTunProcessing.
     ///
     /// - Returns: Void
     ///
     public func CommitConfig () -> Void {
         self.initTunProcessing?(StatusInitTun.Creating, nil)
         if (InfoTun == nil || InfoTun!.user == "") {
             self.initTunProcessing?(StatusInitTun.Failed, "First execute LoadConfig!")
             return
         }
         if InfoTun!.user == "user-demo" {
             self.initTunProcessing?(StatusInitTun.Failed, NSLocalizedString ("TXT_VPN_DEMO_LOGIN", value: "For the successful operation of the program, you must log in!", comment: "TXT_VPN_DEMO_LOGIN_COMMENT"))
             return
         }
         do {
             try self.vpnMan.loadFromPreferences (completionHandler: self.tunLoadHandler)
         } catch let error {
             LibSettings.mcc = 0
             self.currentActiveVpnInfo = nil
             LogManager.Error ("Could not start VPN Connection: \(error.localizedDescription)")
             self.initTunProcessing?(StatusInitTun.Failed, "Could not commit config connection: \(error.localizedDescription)")
         }
     }
     

    /// Остановить связанный туннель
    /// - Parameter callback: ассинхронная функция с результатом выполнения остановки туннеля
     public func StopTun (callback: @escaping (_ status: Bool) -> Void) -> Void {
         self.vpnMan.loadFromPreferences { (error : Error?) in
             let p = self.getBaseProtocol()
             self.vpnMan.protocolConfiguration = p
             self.vpnMan.localizedDescription = self.nameTun
             self.vpnMan.isEnabled = true
             LibSettings.mcc = 0
             do {
                 try self.vpnMan.connection.stopVPNTunnel ()
                 callback (true)
                 self.currentActiveVpnInfo = nil
             } catch let error {
                 LogManager.Error ("Error stoping Tun-VPN Connection \(error.localizedDescription)");
                 callback (false)
                 self.currentActiveVpnInfo = nil
             }
         }
     }
     
     private func callbackNet (errorCode : NetVariables.ErrorCodes, errorString: String) -> Void {
         print("callbackNet: ErrorCode: \(errorCode) ErrorString: \(errorString)");
         switch errorCode {
         
         case .NoneError:
             let outCheck = BaseOut (dataIn: errorString);
             outCheck.Parse ();
             if outCheck.isError () {
                 if outCheck.code == -5 {
                     CryptoManager.Instance.resetDeviceInfo ()
                 }
                 LibSettings.mcc = 0
                 self.loadConfigProcessing? ((StatusLoadConfig.ErrorProgress, NetVariables.ErrorCodes.NoneError), outCheck.getMessage());
             } else {
                 let loginData = ConfigBaseOut (dataIn: errorString)
                 loginData.Parse()
                 if (loginData.isError()) {
                     LibSettings.mcc = 0
                     self.loadConfigProcessing? ((StatusLoadConfig.ErrorProgress, NetVariables.ErrorCodes.NoneError), loginData.getMessage());
                 } else {
                     InfoTun = DataTun (user: (loginData.mc?.work_status.u)!, pasw: (loginData.mc?.work_status.p ?? "" ), srv: (loginData.mc?.work_status.s)!, key: (loginData.mc?.work_status.k)!)
                     AccInfoVpn = loginData.mc?.work_status.vpn_info
                     UserInfo = loginData.mc?.work_status.user_info
                     lastErrorFromServer = loginData.mc?.work_status.error_message
                     self.loadConfigProcessing? ((StatusLoadConfig.EndProcess, NetVariables.ErrorCodes.NoneError), "");
                 }
             }
             break;
             
             
         default:
             LibSettings.mcc = 0
             self.loadConfigProcessing? ((StatusLoadConfig.ErrorProgress, errorCode), errorString);
             break;
         
         }
     }
     
    public class KeychainService: NSObject {
         
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
             keychainQuery[kSecAttrServiceValue as! NSCopying] = "VPN"
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
             keychainQuery[kSecAttrServiceValue as! NSCopying] = "VPN"
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

}

