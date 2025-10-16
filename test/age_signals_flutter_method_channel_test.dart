import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:age_signals_flutter/age_signals_flutter.dart';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:age_signals_flutter/age_signals_flutter.dart';

void main() {
  const MethodChannel channel = MethodChannel('age_signals_flutter');
  TestWidgetsFlutterBinding.ensureInitialized();

  // Setup a mock handler using the new API
  setUp(() {
    ServicesBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      if (methodCall.method == 'getUserStatus') {
        return {
          'userStatus': 'VERIFIED',
          'ageLower': 18,
          'ageUpper': 25,
          'installId': '123-abc',
          'mostRecentApprovalDate': '2025-10-13',
        };
      }
      return null;
    });
  });

  tearDown(() {
    ServicesBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

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

  test('getUserStatus handles errors', () async {
    // Mock an error
    ServicesBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      throw PlatformException(code: 'ERROR', message: 'Failed to fetch');
    });

    final result = await AgeSignalsFlutter.getUserStatus();

    expect(result.error, isNotNull);
    expect(result.userStatus, isNull);
  });
}