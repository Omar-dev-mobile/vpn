import UIKit
import Flutter
import Firebase
import Foundation

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate,MessagingDelegate {
    
    private let EVENT_CHANNEL = "vpn_manager_event"
    private let CHANNEL: String = "vpn_manager"
    private var streamHandler: VPLibDDD?
    
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
    
   

    // Function to create and send a POST request
    func sendPostRequest() {
        guard let url = URL(string: "https://vp-line.aysec.org/ios.php") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        // Directly using the provided parameters dictionary
        let parameters: [String: String] = [
            "oper": "acc",
            "udid": "9fe7fddb-3c3a-4729-87f0-55edd21c3655",
            "rnd": "65180d6d-42f6-4d43-a18b-79e50e561b2c",
            "id_server": "1",
            "signature": "Xb8N/P2/vXdD7rZ4sjFxRp+QZXIHfuUQ6T+VvGY08c9xcy65WqwJptmzfvSHM268pdHSmW7mR+Lht/oZDKJZzHMXzVhRu9zfK5GMUhBN9LPh/hvsb2s2BHAvRx1JckdGCSNU1mFVa0SgQo8LMwlulnlKag02L/j0uyq121TtT2D6E2bQ5uv08Smt0XBLBuDbB/bGWfrVESSwjYdZelVTebsYUxFdv0NIq/lJHeYrPwwvh1Ocb7TIOl+qoRgoIQcV2Zb/qJMao/JkFcL3tpjG80BsvhJLlMpgTk7RWPXEFvpHPRScRV1l5VJEEcsN4Ro8JzNeC3nI7ZZNkqDXythT5A=="
        ]
        let parameterArray = parameters.map { key, value in
            return "\(key)=\(escaping(value))"
        }
        let bodyString = parameterArray.joined(separator: "&")
        request.httpBody = bodyString.data(using: .utf8)
        
        // Creating a URLSession task to send the POST request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error occurred: \(error.localizedDescription)")
                return
            }
            
            // Check the response and data
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                } else {
                    print("No response data to decode")
                }
            } else {
                print("HTTP Status Code: \((response as? HTTPURLResponse)?.statusCode ?? 0)")
            }
        }
        
        // Start the task
        task.resume()
    }

    // Helper function to URL-encode a string
    func escaping(_ value: String) -> String {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        return value.addingPercentEncoding(withAllowedCharacters: allowedCharacters) ?? value
    }

    
    
}


