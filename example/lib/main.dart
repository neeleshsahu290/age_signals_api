import 'package:age_signals_flutter/age_signal_result.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:age_signals_flutter/age_signals_flutter.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _statusMessage = 'Unknown';

  @override
  void initState() {
    super.initState();
    initUserStatus();
  }

  /// Fetch the user's Play age verification status
  Future<void> initUserStatus() async {
  AgeSignalResult result;
  try {
    // Call static method on the class, not the instance
    result = await AgeSignalsFlutter.getUserStatus();
  } on PlatformException catch (e) {
    result = AgeSignalResult(error: e.message);
  }

  if (!mounted) return;

  setState(() {
    if (result.error != null) {
      _statusMessage = 'Error: ${result.error}';
    } else {
      _statusMessage =
          'User Status: ${result.userStatus}\n'
          'Age Range: ${result.ageLower ?? '-'} - ${result.ageUpper ?? '-'}\n'
          'Install ID: ${result.installId ?? '-'}\n'
          'Approved On: ${result.mostRecentApprovalDate ?? '-'}\n'
          'Verified: ${result.isVerified}';
    }
  });
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Age Signals Example'),
        ),
        body: Center(
          child: Text(_statusMessage),
        ),
      ),
    );
  }
}