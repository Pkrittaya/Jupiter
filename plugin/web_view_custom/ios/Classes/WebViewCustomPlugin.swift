import Flutter
import UIKit

public class WebViewCustomPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "web_view_custom", binaryMessenger: registrar.messenger())
    let instance = WebViewCustomPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    registrar.register(WebViewFactory(messenger: registrar.messenger()), withId: "web_view_custom/flutter_web_view")
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}



