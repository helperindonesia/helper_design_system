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
            title: 'Expansion Title',
            children: [Text('After Expand')],
          )),
        ),
      );

      //Verify Widget
      expect(find.text('Expansion Title'), findsOneWidget);
      expect(find.byIcon(Icons.expand_more), findsOneWidget);

      //Tap expansion Icon to Expand
      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();

      //Verify After Expand
      expect(find.text('After Expand'), findsOneWidget);

      //Tap expansion Icon to unExpand
      await tester.tap(find.byIcon(Icons.expand_more));
      await tester.pumpAndSettle();

      //Verify After unExpand
      expect(find.text('After Expand'), findsNothing);
    });
  });
}
