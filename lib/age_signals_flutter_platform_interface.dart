import 'package:age_signals_flutter/age_signal_result.dart';
/// Platform interface for `AgeSignalsFlutter`.
///
/// Platform-specific implementations should extend this class.
abstract class AgeSignalsFlutterPlatform {
  /// Constructs an instance of [AgeSignalsFlutterPlatform].
  AgeSignalsFlutterPlatform();

  /// Fetch the user's Play age verification status.
  ///
  /// Returns an [AgeSignalResult] containing:
  /// - `userStatus`: VERIFIED / UNVERIFIED
  /// - `ageLower` and `ageUpper` bounds (if available)
  /// - `installId` of the Play install
  /// - `mostRecentApprovalDate` if verified
  Future<AgeSignalResult> getUserStatus();
}

