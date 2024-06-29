import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:sms_display_app/widgets/message_tile.dart';
import 'package:telephony/telephony.dart';

class MockSmsMessage extends Mock implements SmsMessage {
  @override
  String? get address => '1234';

  @override
  String? get body => 'Test Message';

  @override
  int? get dateSent => 1622023200000;
}

void main() {
  testWidgets('MessageTile displays message information',
      (WidgetTester tester) async {
    final SmsMessage message = MockSmsMessage();

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: MessageTile(message: message),
      ),
    ));

    expect(find.text('1234'), findsOneWidget);
    expect(find.text('Test Message'), findsOneWidget);
    expect(find.text('10:00 5/26/2021'), findsOneWidget);
  });
}
