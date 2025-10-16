import 'package:flutter_test/flutter_test.dart';
import 'package:age_signals_flutter/age_signals_flutter.dart';


void main() {
  TestWidgetsFlutterBinding.ensureInitialized();


  test('getUserStatus returns correct AgeSignalResult', () async {
    final result = await AgeSignalsFlutter.getUserStatus();

    expect(result.userStatus, 'VERIFIED');
    expect(result.ageLower, 18);
    expect(result.ageUpper, 25);
    expect(result.installId, '123-abc');
    expect(result.mostRecentApprovalDate, '2025-10-13');
    expect(result.isVerified, true);
    expect(result.error, isNull);
  });
}
