import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    private let EVENT_CHANNEL = "vpn_manager_event"
    private let CHANNEL: String = "vpn_manager"
    private var streamHandler: VPLibDDD?
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        setUpMethodChannel()
        setUpEventChannel()
        
        
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
            self.streamHandler = VPLibDDD()
        }
//        let vpnManager = VPLibDDD()
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
            self.streamHandler = VPLibDDD()
        }
        eventChannel.setStreamHandler((self.streamHandler as! FlutterStreamHandler & NSObjectProtocol))
    }
    
    
}
