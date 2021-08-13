import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  group('Swipe Button Test', () {
    bool? _value;
    testWidgets('Swipe Button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SwipeButton(
              onConfirmation: () {
                _value = true;
              },
            ),
          ),
        ),
      );

      //Verify Widget
      expect(_value, isNull);
      expect(find.byIcon(Icons.arrow_circle_up_rounded), findsOneWidget);

      //Drag/Swipe Icon to Right
      await tester.drag(
          find.byIcon(Icons.arrow_circle_up_rounded), const Offset(300, 0));
      await tester.pumpAndSettle();

      //Verify After Drag/Swipe
      expect(_value, isTrue);
      expect(find.byIcon(Icons.check_circle_rounded), findsOneWidget);
    });
  });

  group('Circle Icon Button Test', () {
    testWidgets('Circle Icon Button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home:
              Scaffold(body: CircleIconButton(onPressed: () {}, badgeCount: 1)),
        ),
      );

      //Verify Widget
      expect(find.byIcon(Icons.chat_bubble_rounded), findsOneWidget);
      expect(find.text('1'), findsOneWidget);
    });
  });
}
