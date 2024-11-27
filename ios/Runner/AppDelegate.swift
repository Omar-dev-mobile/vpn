import UIKit
import Flutter
import Firebase
import Foundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate,MessagingDelegate {
    
    private let EVENT_CHANNEL = "vpn_manager_event"
    private let CHANNEL: String = "vpn_manager"
    private var streamHandler: VPNManager?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        FirebaseApp.configure()
//        sendPostRequest()
    Messaging.messaging().delegate = self
    if #available(iOS 14.0, *) {
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
    } else {
        let settings: UIUserNotificationSettings =
        UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
    }
        setUpMethodChannel()
        setUpEventChannel()


         let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let testFlightChannel = FlutterMethodChannel(name: "app/testflight",
                                                  binaryMessenger: controller.binaryMessenger)

    testFlightChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if (call.method == "isTestFlight") {
        if let receiptUrl = Bundle.main.appStoreReceiptURL {
          result(receiptUrl.lastPathComponent == "sandboxReceipt")
        } else {
          result(false)
        }
      } else {
        result(FlutterMethodNotImplemented)
      }
    })
        
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func setUpMethodChannel() {
            guard let controller: FlutterViewController = window?.rootViewController as? FlutterViewController else {
                fatalError("Invalid root view controller")
            }
        let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
        let vpnChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: flutterViewController.binaryMessenger)
        if (self.streamHandler == nil) {

            self.streamHandler = VPNManager()
        }
//        let vpnManager = VPNManager()
        vpnChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            self.streamHandler?.handle(call, result: result)
        }
        }
    
    func setUpEventChannel() {
           guard let controller: FlutterViewController = window?.rootViewController as? FlutterViewController else {
               fatalError("Invalid root view controller")
           }
           
        let eventChannel = FlutterEventChannel(name: EVENT_CHANNEL, binaryMessenger: controller.binaryMessenger)
        
        if (self.streamHandler == nil) {
            self.streamHandler = VPNManager()
        }
        eventChannel.setStreamHandler((self.streamHandler as! FlutterStreamHandler & NSObjectProtocol))
    }
    
   

   
    // Helper function to URL-encode a string
    func escaping(_ value: String) -> String {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return value.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? value
    }

    
    
}


