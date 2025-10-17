import Flutter
import UIKit
import DeviceCheck

public class AgeSignalsFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "age_signals_flutter", binaryMessenger: registrar.messenger())
    let instance = AgeSignalsFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getUserStatus":
      if #available(iOS 17.0, *) {
        do {
          if let ageRange = try DCAppAttestService.shared.getAgeRange() {

            let data: [String: Any?] = [
             "userStatus": ageRange.userStatus,
             "ageLower": ageRange.lowerBound,
             "ageUpper": ageRange.upperBound,
             "installId": ageRange.installId,
             "mostRecentApprovalDate": ageRange.mostRecentApprovalDate
             ]
           result(data)
          } else {
            result("unknown")
          }
        } catch {
          result("Error retrieving age range: \(error.localizedDescription)")
        }
      } else {
        result("unsupported")
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}



