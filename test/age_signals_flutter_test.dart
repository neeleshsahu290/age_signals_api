import 'package:age_signals_flutter/age_signal_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:age_signals_flutter/age_signals_flutter.dart';
import 'package:age_signals_flutter/age_signals_flutter_platform_interface.dart';
import 'package:age_signals_flutter/age_signals_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';


// Mock platform implementation
class MockAgeSignalsFlutterPlatform
    with MockPlatformInterfaceMixin
    implements AgeSignalsFlutterPlatform {

  @override
  Future<AgeSignalResult> getUserStatus() async {
    return AgeSignalResult(
      userStatus: 'VERIFIED',
      ageLower: 18,
      ageUpper: 25,
      installId: '123-abc',
      mostRecentApprovalDate: '2025-10-13',
    );
  }
}

void main() {
  final AgeSignalsFlutterPlatform initialPlatform = AgeSignalsFlutterPlatform.instance;

  test('$MethodChannelAgeSignalsFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAgeSignalsFlutter>());
  });

  test('getUserStatus returns correct AgeSignalResult', () async {
    AgeSignalsFlutter ageSignalsFlutterPlugin = AgeSignalsFlutter();
    MockAgeSignalsFlutterPlatform fakePlatform = MockAgeSignalsFlutterPlatform();
    AgeSignalsFlutterPlatform.instance = fakePlatform;

    final result = await ageSignalsFlutterPlugin.getUserStatus();

    expect(result.userStatus, 'VERIFIED');
    expect(result.ageLower, 18);
    expect(result.ageUpper, 25);
    expect(result.installId, '123-abc');
    expect(result.mostRecentApprovalDate, '2025-10-13');
    expect(result.isVerified, true);
    expect(result.error, isNull);
  });
}