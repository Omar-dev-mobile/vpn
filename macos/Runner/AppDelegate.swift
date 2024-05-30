import Cocoa
import FlutterMacOS
import Firebase

@NSApplicationMain
class AppDelegate: FlutterAppDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {
    private let EVENT_CHANNEL = "vpn_manager_event"
    private let CHANNEL: String = "vpn_manager"
    private var streamHandler: VPLibDDD?
    var window: NSWindow!
    
    override init() {
        super.init()
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
    }
      
    }
    


    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

   
}
