// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sms_display_app/main.dart';

void main() {
  testWidgets('App starts and shows SmsListScreen',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Messages'), findsOneWidget);
  });
}
