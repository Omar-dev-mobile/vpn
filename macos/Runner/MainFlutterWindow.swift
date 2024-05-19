import Cocoa
import FlutterMacOS
import window_manager

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)
        
        // Set up the VPN Method Channel
        let vpnChannel = FlutterMethodChannel(name: "vpn_manager", binaryMessenger: flutterViewController.engine.binaryMessenger)
        let streamHandler = VPLibDDD()
        vpnChannel.setMethodCallHandler { (call, result) in
            streamHandler.handle(call, result: result)
        }
        
        // Set up the VPN Event Channel
        let eventChannel = FlutterEventChannel(name: "vpn_manager_event", binaryMessenger: flutterViewController.engine.binaryMessenger)
        eventChannel.setStreamHandler(streamHandler)

        RegisterGeneratedPlugins(registry: flutterViewController)
        super.awakeFromNib()
    }

    override public func order(_ place: NSWindow.OrderingMode, relativeTo otherWin: Int) {
         super.order(place, relativeTo: otherWin)
         hiddenWindowAtLaunch()
     }
}

