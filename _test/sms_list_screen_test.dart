import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:telephony/telephony.dart';
import 'package:sms_display_app/screens/sms_list_screen.dart';

class MockTelephony extends Mock implements Telephony {}

class MockSmsMessage extends Mock implements SmsMessage {
  @override
  String? get address => '1234';

  @override
  String? get body => 'Test Message 1';

  @override
  int? get dateSent => 1622023200000;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SmsListScreen', () {
    late MockTelephony mockTelephony;

    setUp(() {
      mockTelephony = MockTelephony();
    });

    testWidgets('displays messages correctly', (WidgetTester tester) async {
      when(mockTelephony.getInboxSms()).thenAnswer(
        (_) async => [
          MockSmsMessage(),
          MockSmsMessage()
            ..body = 'Test Message 2'
            ..address = '5678'
            ..dateSent = 1622109600000,
        ],
      );

      await tester.pumpWidget(MaterialApp(home: SmsListScreen()));

      expect(find.text('Messages'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump();

      expect(find.byType(ListTile), findsNWidgets(2));
      expect(find.text('Test Message 1'), findsOneWidget);
      expect(find.text('Test Message 2'), findsOneWidget);
    });
  });
}
