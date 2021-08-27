import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  group('Primary Card', () {
    bool? _value;
    testWidgets('Primary Card', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PrimaryCard(
            illustrationImage: 'example/assets/images/ilustrasi_beri_tip.webp',
            onPressed: () {
              _value = true;
            },
          ),
        ),
      ));

      //Verify Widget
      expect(_value, isNull);
      expect(find.text('Beri Tip'), findsOneWidget);

      //Tap Beri Tip
      await tester.tap(find.text('Beri Tip'));

      //Verify After tap
      expect(_value, isTrue);
    });
  });
}
