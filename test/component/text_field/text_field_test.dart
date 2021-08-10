import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  group('Outline Text Field', () {
    testWidgets('Find Widget and Type "Hi" ', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: OutlineTextField(),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'Hi');
      expect(find.text('Hi'), findsOneWidget);
    });
  });

  group('Text Field Counter', () {
    testWidgets('Increment', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldCounter(
              value: 1,
            ),
          ),
        ),
      );

      expect(find.byType(OutlineTextField), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add_rounded));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.add_rounded));
      await tester.pump();
      expect(find.text('3'), findsOneWidget);
    });

    testWidgets('Decrement', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldCounter(
              value: 3,
            ),
          ),
        ),
      );

      expect(find.byType(OutlineTextField), findsOneWidget);

      await tester.tap(find.byIcon(Icons.remove_rounded));
      await tester.pump();
      expect(find.text('2'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.remove_rounded));
      await tester.pump();
      expect(find.text('1'), findsOneWidget);
    });
  });

  group('Text Field With Expansion View', () {
    testWidgets('Find Widget and Type "Hi" ', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldWithExpansionView(
              expansionTitle: 'Expansion',
              labelText: 'Expansion',
            ),
          ),
        ),
      );

      expect(find.byType(TextFormField), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'Hi');
      expect(find.text('Hi'), findsOneWidget);
    });

    testWidgets('Expansion Click to Show and Hide Expansion Children', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TextFieldWithExpansionView(
              expansionTitle: 'Expansion',
              labelText: 'Expansion',
              expansionChildren: [Text('After Expand')],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.expand_more), findsOneWidget);

      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();
      expect(find.text('After Expand'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();
      expect(find.text('After Expand'), findsNothing);
    });
  });
}
