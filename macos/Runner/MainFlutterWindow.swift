import Cocoa
import FlutterMacOS
import window_manager

class MainFlutterWindow: NSWindow {
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController.init()
            let windowFrame = self.frame
            self.contentViewController = flutterViewController
            self.setFrame(windowFrame, display: true)

            // Set the initial window size
            self.setContentSize(NSSize(width: 450, height: 600))
            
            // Set the minimum and maximum window sizes
            self.minSize = NSSize(width: 450, height: 550)
            self.maxSize = NSSize(width: 550, height: 700)
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
}

