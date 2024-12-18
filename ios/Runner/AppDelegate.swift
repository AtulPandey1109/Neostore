import Flutter
import UIKit
import GoogleMaps
import flutter_config

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey(FlutterConfigPlugin.env(for: "Google_Maps_API_Ios"))
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
