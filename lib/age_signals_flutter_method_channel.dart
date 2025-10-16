import 'package:age_signals_flutter/age_signal_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'age_signals_flutter_platform_interface.dart';


/// An implementation of [AgeSignalsFlutterPlatform] that communicates with
/// the native platform using a [MethodChannel].
///
/// This class handles the platform-specific logic for fetching the user's
/// Play age verification status.
class MethodChannelAgeSignalsFlutter extends AgeSignalsFlutterPlatform {
  /// The [MethodChannel] used to send and receive messages to/from
  /// the native Android/iOS implementation.
  @visibleForTesting
  final methodChannel = const MethodChannel('age_signals_flutter');

  /// Fetches the user's Play age verification status via the MethodChannel.
  ///
  /// Returns an [AgeSignalResult] containing:
  /// - `userStatus`: VERIFIED / UNVERIFIED
  /// - `ageLower` and `ageUpper` bounds (if available)
  /// - `installId`: unique identifier of the Play install
  /// - `mostRecentApprovalDate`: date of last verification
  /// - `error`: any error encountered during the verification process
  ///
  /// If an exception occurs while invoking the platform method, it is caught
  /// and returned as the `error` field in the [AgeSignalResult].
  @override
  Future<AgeSignalResult> getUserStatus() async {
    try {
      final Map<dynamic, dynamic> res =
          await methodChannel.invokeMethod('getUserStatus');
      return AgeSignalResult.fromMap(Map<String, dynamic>.from(res));
    } catch (e) {
      return AgeSignalResult(error: e.toString());
    }
  }
}