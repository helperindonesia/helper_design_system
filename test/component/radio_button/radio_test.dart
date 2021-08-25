import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  group('Radio Button', () {
    testWidgets('Radio Button Test', (WidgetTester tester) async {
      String? _value;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: Column(
            children: [
              HRadio(
                title: 'First Radio Button',
                value: 'First',
                groupValue: _value,
                onChanged: (String? value) {
                  _value = value;
                },
              ),
              HRadio(
                title: 'Second Radio Button',
                value: 'Second',
                groupValue: _value,
                onChanged: (String? value) {
                  _value = value;
                },
              )
            ],
          )),
        ),
      );

      //verify first State
      expect(_value, isNull);
      expect(find.text('First Radio Button'), findsOneWidget);
      expect(find.text('Second Radio Button'), findsOneWidget);

      //First Button tap test
      await tester.tap(find.text('First Radio Button'));

      //Verify value after tap first radio button
      expect(_value, isNotNull);
      expect(_value, 'First');

      //Second Button tap test
      await tester.tap(find.text('Second Radio Button'));

      //verify value after tap second radio button
      expect(_value, isNotNull);
      expect(_value, 'Second');
    });
  });
}
