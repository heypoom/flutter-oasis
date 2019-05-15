import UIKit
import Flutter

public class SwiftOasisPlugin : NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "oasis",
            binaryMessenger: registrar.messenger()
        )

        let instance = SwiftOasisPlugin()

        registrar.addMethodCallDelegate(instance, channel: channel)
        registrar.addApplicationDelegate(instance)
        
        let viewFactory = OasisViewFactory()
        
        registrar.register(viewFactory, withId: "OasisView")
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
            case "getDeviceInfo":
                result(getDeviceInfo())
            case "showAlertDialog":
                showAlertDialog()
                result(true)
            default:
                result(false)
        }
    }
    
    public func showAlertDialog() {
        let device = UIDevice.current
        let name = device.name
        
        DispatchQueue.main.async {
            let alert = UIAlertController(
                title: "Hey There ⚡️",
                message: "Device Name is \(name)",
                preferredStyle: .alert
            )
            
            let action = UIAlertAction(
                title: "Boom!",
                style: UIAlertActionStyle.destructive,
                handler: nil
            )

            alert.addAction(action)

            UIApplication.shared.keyWindow?.rootViewController?.present(
                alert,
                animated: true,
                completion: nil
            )
        }
    }
    
    public func getDeviceInfo() -> String {
        let dev = UIDevice.current
        
        return dev.systemName
    }
}

public class OasisView : NSObject, FlutterPlatformView {
    let frame: CGRect
    let viewId: Int64
    
    init(_ frame: CGRect, viewId: Int64, args: Any?) {
        self.frame = frame
        self.viewId = viewId
    }
    
    public func view() -> UIView {
        return UISlider(frame: frame)
    }
}

public class OasisViewFactory : NSObject, FlutterPlatformViewFactory {
    public func create(
        withFrame frame: CGRect,
        viewIdentifier viewId: Int64,
        arguments args: Any?
        ) -> FlutterPlatformView {
        return OasisView(
            frame,
            viewId: viewId,
            args: args
        )
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    SwiftOasisPlugin.register(with: registrar(forPlugin: "oasis"))
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
