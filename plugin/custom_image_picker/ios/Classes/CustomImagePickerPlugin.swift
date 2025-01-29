import Flutter
import UIKit

@available(iOS 14.0, *)
public class CustomImagePickerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "custom_image_picker", binaryMessenger: registrar.messenger())
     let eventChannel = FlutterEventChannel(name: "PickerHandler", binaryMessenger: registrar.messenger())
      eventChannel.setStreamHandler(NativeStreamHandler())
    let instance = CustomImagePickerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
      
      let defaults = UserDefaults.standard
      let key = "ImageClick"
      defaults.removeObject(forKey: key)

//      registrar.chan
      registrar.register(PickerFactory(messenger: registrar.messenger()), withId: "custom_image_picker/flutter_picker")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
  
      
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
