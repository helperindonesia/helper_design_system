import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  group('Switch Control Test', () {
    testWidgets('Switch Control Toggle Tap', (WidgetTester tester) async {
      bool value = false;
      final Key switchKey = UniqueKey();

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (_, StateSetter setState) {
            return MaterialApp(
              home: Scaffold(
                body: Center(
                    child: SwitchControl(
                  key: switchKey,
                  value: value,
                  onToggle: (bool newValue) {
                    setState(() {
                      value = newValue;
                    });
                  },
                )),
              ),
            );
          },
        ),
      );

      //Verify default Value of Switch
      expect(value, isFalse);

      //Tap Switch
      await tester.tap(find.byKey(switchKey));
      await tester.pump();

      //Verify newValue(enable) after switch
      expect(value, isTrue);

      //Tap Switch
      await tester.tap(find.byKey(switchKey));
      await tester.pump();

      //Verify newValue(disable) after switch
      expect(value, isFalse);
    });
  });
}
