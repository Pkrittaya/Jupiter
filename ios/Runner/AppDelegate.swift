import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
         GeneratedPluginRegistrant.register(with: registry)
       }
          GeneratedPluginRegistrant.register(with: self)
    // let googleMapApiKey = Bundle.main.object(forInfoDictionaryKey: "MAPS_API_KEY_IOS") as? String
      guard let infoDictionary: [String: Any] = Bundle.main.infoDictionary else { return false}
      
      guard let apiKeyString: String = infoDictionary["MAP_API_KEY"] as? String else { return false }

      print("apiKeyString -> \(apiKeyString)")
      

      
      GMSServices.provideAPIKey(apiKeyString)


   if #available(iOS 10.0, *) {
  UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
}
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
