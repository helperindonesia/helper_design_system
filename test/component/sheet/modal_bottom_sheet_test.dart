import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  group('Modal Bottom Sheet Test', () {
    testWidgets('Show Modal Bottom Sheet and Tap Inside', (WidgetTester tester) async {
      late BuildContext context;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext buildContext) {
              context = buildContext;
              return Container();
            },
          ),
        ),
      );

      //Verify before showing BottomSheet
      expect(find.text('BottomSheet'), findsNothing);

      //Show Bottom Sheet
      showModalBottomSheet<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ModalBottomSheet(children: [Text('BottomSheet')]);
          });

      await tester.pumpAndSettle();

      //Verify Bottom Sheet
      expect(find.text('BottomSheet'), findsOneWidget);

      //Tap inside Bottom Sheet
      await tester.tap(find.text('BottomSheet'));
      await tester.pumpAndSettle();

      //Verify Bottom Sheet After Tap
      expect(find.text('BottomSheet'), findsOneWidget);
    });

    testWidgets('Show Modal Bottom Sheet and Tap Outside', (WidgetTester tester) async {
      late BuildContext context;

      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (BuildContext buildContext) {
              context = buildContext;
              return Container();
            },
          ),
        ),
      );

      //Verify before showing BottomSheet
      expect(find.text('BottomSheet'), findsNothing);
      //Show Bottom Sheet
      showModalBottomSheet<dynamic>(
          context: context,
          builder: (BuildContext context) {
            return ModalBottomSheet(children: [Text('BottomSheet')]);
          });

      await tester.pumpAndSettle();

      //Verify Bottom Sheet
      expect(find.text('BottomSheet'), findsOneWidget);

      //Tap outside Bottom Sheet
      await tester.tapAt(const Offset(20.0, 20.0));
      await tester.pumpAndSettle();

      //Verify Bottom Sheet After Tap
      expect(find.text('BottomSheet'), findsNothing);
    });
  });
}
