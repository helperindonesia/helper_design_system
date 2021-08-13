import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  group('Date Time Picker Test', () {
    testWidgets('datetime picker', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: DateTimePickerView(
                minTime: DateTime(2021, 8, 13, 17, 0),
                currentTime:
                    DateTime(2021, 8, 13, 17, 0).add(Duration(hours: 3)),
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      //Verify day showing in Widget
      expect(find.text('Hari Ini'), findsOneWidget); //Selected
      expect(find.text('Sabtu, 14 Agu'), findsOneWidget);
      expect(find.text('Minggu, 15 Agu'), findsOneWidget);
      expect(find.text('Senin, 16 Agu'), findsOneWidget);

      //Verify hours showing in Widget
      expect(find.text('17'), findsOneWidget);
      expect(find.text('18'), findsOneWidget);
      expect(find.text('19'), findsOneWidget);
      expect(find.text('20'), findsOneWidget); // Selected
      expect(find.text('21'), findsOneWidget);
      expect(find.text('22'), findsOneWidget);
      expect(find.text('23'), findsOneWidget);

      //Verify minute showing in Widget
      expect(find.text('00'), findsOneWidget); //Selected
      expect(find.text('01'), findsOneWidget);
      expect(find.text('02'), findsOneWidget);
      expect(find.text('03'), findsOneWidget);
    });
  });
}
