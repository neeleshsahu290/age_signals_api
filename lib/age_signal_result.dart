/// Represents the result of the Google Play Age Signals verification.
class AgeSignalResult {
  /// The user's verification status.
  ///
  /// Typical values:
  /// - 'VERIFIED': The user has been age-verified.
  /// - null or other string: Not verified or unknown status.
  final String? userStatus;

  /// The lower bound of the user's age, if available.
  ///
  /// Example: 18
  final int? ageLower;

  /// The upper bound of the user's age, if available.
  ///
  /// Example: 25
  final int? ageUpper;

  /// A unique identifier for the installation.
  ///
  /// Typically corresponds to the Google Play install ID.
  final String? installId;

  /// The most recent date when the age verification was approved.
  ///
  /// Format: ISO 8601 string (e.g., "2025-10-13").
  final String? mostRecentApprovalDate;

  /// Any error encountered during the verification process.
  ///
  /// Contains the error message if verification failed.
  final String? error;

  /// Returns true if the user's status is verified.
  bool get isVerified => userStatus == 'VERIFIED';

  /// Constructs an [AgeSignalResult] instance.
  ///
  /// All fields are optional, because data may be incomplete or
  /// verification may fail.
  AgeSignalResult({
    this.userStatus,
    this.ageLower,
    this.ageUpper,
    this.installId,
    this.mostRecentApprovalDate,
    this.error,
  });

  /// Creates an [AgeSignalResult] from a [Map] returned by the MethodChannel.
  ///
  /// Safely parses integers and converts all fields to strings if necessary.
  factory AgeSignalResult.fromMap(Map<String, dynamic> map) => AgeSignalResult(
        userStatus: map['userStatus'],
        ageLower: map['ageLower'] is int
            ? map['ageLower']
            : (map['ageLower'] != null
                ? int.tryParse(map['ageLower'].toString())
                : null),
        ageUpper: map['ageUpper'] is int
            ? map['ageUpper']
            : (map['ageUpper'] != null
                ? int.tryParse(map['ageUpper'].toString())
                : null),
        installId: map['installId']?.toString(),
        mostRecentApprovalDate: map['mostRecentApprovalDate']?.toString(),
        error: map['error']?.toString(),
      );

  @override
  String toString() =>
      'AgeSignalResult(status: $userStatus, lower: $ageLower, upper: $ageUpper, id: $installId)';
}