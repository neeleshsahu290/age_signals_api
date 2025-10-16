
import 'package:age_signals_flutter/age_signal_result.dart';
import 'package:age_signals_flutter/age_signals_flutter_method_channel.dart';
import 'age_signals_flutter_platform_interface.dart';


/// Main entry point for interacting with the Google Play Age Signals API
/// through Flutter.
///
/// This class provides static methods to fetch the user's age verification
/// status from Google Play. It communicates with the platform-specific
/// implementation via the [AgeSignalsFlutterPlatform] interface.
class AgeSignalsFlutter {
  /// The platform-specific implementation of [AgeSignalsFlutterPlatform].
  ///
  /// Defaults to [MethodChannelAgeSignalsFlutter] which uses a MethodChannel
  /// to communicate with native Android/iOS code.
  static final AgeSignalsFlutterPlatform _platform = MethodChannelAgeSignalsFlutter();

  /// Fetches the user's Play age verification status.
  ///
  /// Returns an [AgeSignalResult] containing:
  /// - `userStatus`: VERIFIED / UNVERIFIED
  /// - `ageLower` and `ageUpper` bounds (if available)
  /// - `installId`: unique identifier of the Play installation
  /// - `mostRecentApprovalDate`: date of last verification
  /// - `error`: any error encountered during the verification process
  ///
  /// Example usage:
  /// ```dart
  /// final result = await AgeSignalsFlutter.getUserStatus();
  /// if (result.isVerified) {
  ///   print('User is verified: ${result.ageLower}-${result.ageUpper}');
  /// } else {
  ///   print('Verification failed: ${result.error}');
  /// }
  /// ```
  static Future<AgeSignalResult> getUserStatus() {
    return _platform.getUserStatus();
  }
}