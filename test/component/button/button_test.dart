import 'package:flutter/material.dart' hide OutlinedButton;
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
    bool? _value;
    Key key = Key('Circle Icon Button');
    testWidgets('Circle Icon Button', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: CircleIconButton(
                  key: key,
                  onPressed: () {
                    _value = true;
                  },
                  badgeCount: 1)),
        ),
      );

      //Verify Widget
      expect(_value, isNull);
      expect(find.byIcon(Icons.chat_bubble_rounded), findsOneWidget);
      expect(find.text('1'), findsOneWidget);

      //Tap Circle Icon Button
      await tester.tap(find.byKey(key));

      //Verify Circle Icon Button after tap
      expect(_value, isTrue);
    });
  });

  group('Primary Button', () {
    bool? _value;
    testWidgets('Primary Button', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PrimaryButton(
            onPressed: () {
              _value = true;
            },
            text: 'Primary Button',
          ),
        ),
      ));

      //Verify Widget
      expect(_value, isNull);
      expect(find.text('Primary Button'), findsOneWidget);

      //Tap primary button
      await tester.tap(find.text('Primary Button'));

      //Verify after tap Primary Button
      expect(_value, isTrue);
    });
  });

  group('Outlined Button', () {
    bool? _value;
    testWidgets('Outlined Button', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: OutlinedButton(
            text: 'Outlined Button',
            onPressed: () {
              _value = true;
            },
          ),
        ),
      ));

      //Verify Widget
      expect(_value, isNull);
      expect(find.text('Outlined Button'), findsOneWidget);

      //Tap Outlined Button
      await tester.tap(find.text('Outlined Button'));

      //Verify Outlined Button after tap
      expect(_value, isTrue);
    });
  });
}
