import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  group('Expansion View Test', () {
    testWidgets('Show and Hide children in Expand',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
              body: ExpansionView(
            title: 'Expansion',
            children: [Text('After Expand')],
          )),
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
