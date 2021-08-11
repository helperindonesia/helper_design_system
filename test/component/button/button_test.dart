import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  group('Swipe Button Test', () {
    testWidgets('Swipe Button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SwipeButton(
              onConfirmation: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_circle_up_rounded), findsOneWidget);

      await tester.drag(
          find.byIcon(Icons.arrow_circle_up_rounded), const Offset(300, 0));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    });
  });
}
