import Cocoa
import FlutterMacOS
import Firebase

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    private let EVENT_CHANNEL = "vpn_manager_event"
    private let CHANNEL: String = "vpn_manager"
    private var streamHandler: VPLibDDD?
    var window: NSWindow!
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        setUpMethodChannel()
        setUpEventChannel()
        return true
    }

    func setUpMethodChannel() {
        guard let controller = window.contentViewController as? FlutterViewController else {
            fatalError("Invalid root view controller")
        }
        let vpnChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.engine.binaryMessenger)
        if (self.streamHandler == nil) {
            self.streamHandler = VPLibDDD()
        }
        vpnChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            self.streamHandler?.handle(call, result: result)
        }
    }

    func setUpEventChannel() {
        guard let controller = window.contentViewController as? FlutterViewController else {
            fatalError("Invalid root view controller")
        }
        let eventChannel = FlutterEventChannel(name: EVENT_CHANNEL, binaryMessenger: controller.engine.binaryMessenger)
        if (self.streamHandler == nil) {
            self.streamHandler = VPLibDDD()
        }
        eventChannel.setStreamHandler(self.streamHandler)
    }
}
