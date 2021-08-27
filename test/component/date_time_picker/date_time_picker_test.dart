import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  const Offset _dragUp = Offset(0.0, 500);
  const Offset _dragDown = Offset(0.0, -500);
  group('Date Time Picker Test', () {
    testWidgets('datetime picker', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: DateTimePickerView(
                minTime: DateTime(2021, 8, 13, 17, 0),
                currentTime:
                    DateTime(2021, 8, 13, 17, 0).add(Duration(hours: 3)),
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      //Verify day showing in Widget
      expect(find.text('Jumat, 13 Agu'), findsOneWidget); //Selected
      expect(find.text('Sabtu, 14 Agu'), findsOneWidget);
      expect(find.text('Minggu, 15 Agu'), findsOneWidget);
      expect(find.text('Senin, 16 Agu'), findsOneWidget);

      //Verify hours showing in Widget
      expect(find.text('17'), findsOneWidget);
      expect(find.text('18'), findsOneWidget);
      expect(find.text('19'), findsOneWidget);
      expect(find.text('20'), findsOneWidget); // Selected
      expect(find.text('21'), findsOneWidget);
      expect(find.text('22'), findsOneWidget);
      expect(find.text('23'), findsOneWidget);

      //Verify minute showing in Widget
      expect(find.text('00'), findsOneWidget); //Selected
      expect(find.text('01'), findsOneWidget);
      expect(find.text('02'), findsOneWidget);
      expect(find.text('03'), findsOneWidget);
    });

    testWidgets('Date Time Picker Today', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: DateTimePickerView(
                onChanged: (_) {},
              ),
            ),
          ),
        ),
      );

      //Verify Today
      expect(find.text('Hari Ini'), findsOneWidget);
    });
  });

  group('Drag up Widget', () {
    testWidgets('Drag Up Minute', (WidgetTester tester) async {
      DateTime? dateTime;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: DateTimePickerView(
                minTime: DateTime(2021, 8, 13, 14, 0),
                currentTime: DateTime(2021, 8, 13, 17, 0)
                    .add(Duration(hours: 3, minutes: 10)),
                onChanged: (DateTime d) {
                  dateTime = d;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('07'), findsOneWidget);
      expect(find.text('08'), findsOneWidget);
      expect(find.text('09'), findsOneWidget);
      expect(find.text('10'), findsOneWidget); //Selected
      expect(find.text('11'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('13'), findsOneWidget);

      //Verify Drag up minute
      await tester.drag(find.text('09'), _dragUp, warnIfMissed: false);
      expect(dateTime, DateTime(2021, 8, 13, 20, 00));
    });

    testWidgets('Drag Up Hour', (WidgetTester tester) async {
      DateTime? dateTime;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: DateTimePickerView(
                minTime: DateTime(2021, 8, 13, 14, 0),
                currentTime: DateTime(2021, 8, 13, 17, 0)
                    .add(Duration(hours: 3, minutes: 10)),
                onChanged: (DateTime d) {
                  dateTime = d;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('17'), findsOneWidget);
      expect(find.text('18'), findsOneWidget);
      expect(find.text('19'), findsOneWidget);
      expect(find.text('20'), findsOneWidget); //Selected
      expect(find.text('21'), findsOneWidget);
      expect(find.text('23'), findsOneWidget);

      //Verify Drag up Hour
      await tester.drag(find.text('19'), _dragUp, warnIfMissed: false);
      expect(dateTime, DateTime(2021, 8, 13, 10, 10));
    });

    testWidgets('Drag Up Day', (WidgetTester tester) async {
      DateTime? dateTime;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: DateTimePickerView(
                minTime: DateTime(2021, 8, 10, 14, 0),
                currentTime: DateTime(2021, 8, 13, 17, 0)
                    .add(Duration(hours: 3, minutes: 10)),
                onChanged: (DateTime d) {
                  dateTime = d;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Jumat, 13 Agu'), findsOneWidget); //Selected
      expect(find.text('Sabtu, 14 Agu'), findsOneWidget);
      expect(find.text('Minggu, 15 Agu'), findsOneWidget);
      expect(find.text('Senin, 16 Agu'), findsOneWidget);

      //Verify Drag Up Day
      await tester.drag(find.text('Kamis, 12 Agu'), _dragUp, warnIfMissed: false);
      expect(dateTime, DateTime(2021, 8, 10, 23, 10));
    });
  });

  group('Drag Down Widget', () {
    testWidgets('Drag Down Minute', (WidgetTester tester) async {
      DateTime? dateTime;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: DateTimePickerView(
                minTime: DateTime(2021, 8, 13, 14, 0),
                currentTime: DateTime(2021, 8, 13, 17, 0)
                    .add(Duration(hours: 3, minutes: 10)),
                onChanged: (DateTime d) {
                  dateTime = d;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('07'), findsOneWidget);
      expect(find.text('08'), findsOneWidget);
      expect(find.text('09'), findsOneWidget);
      expect(find.text('10'), findsOneWidget); //Selected
      expect(find.text('11'), findsOneWidget);
      expect(find.text('12'), findsOneWidget);
      expect(find.text('13'), findsOneWidget);

      //Verify Drag down minute
      await tester.drag(find.text('09'), _dragDown, warnIfMissed: false);
      expect(dateTime, DateTime(2021, 8, 13, 20, 20));
    });

    testWidgets('Drag Down Hour', (WidgetTester tester) async {
      DateTime? dateTime;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: DateTimePickerView(
                minTime: DateTime(2021, 8, 13, 14, 0),
                currentTime: DateTime(2021, 8, 13, 17, 0)
                    .add(Duration(hours: 3, minutes: 10)),
                onChanged: (DateTime d) {
                  dateTime = d;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('17'), findsOneWidget);
      expect(find.text('18'), findsOneWidget);
      expect(find.text('19'), findsOneWidget);
      expect(find.text('20'), findsOneWidget); //Selected
      expect(find.text('21'), findsOneWidget);
      expect(find.text('23'), findsOneWidget);

      //Verify Drag down Hour
      await tester.drag(find.text('19'), _dragDown, warnIfMissed: false);
      expect(dateTime, DateTime(2021, 8, 13, 23, 10));
    });

    testWidgets('Drag Down Day', (WidgetTester tester) async {
      DateTime? dateTime;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SizedBox(
              width: 400,
              height: 400,
              child: DateTimePickerView(
                minTime: DateTime(2021, 8, 10, 14, 0),
                currentTime: DateTime(2021, 8, 13, 17, 0)
                    .add(Duration(hours: 3, minutes: 10)),
                onChanged: (DateTime d) {
                  dateTime = d;
                },
              ),
            ),
          ),
        ),
      );

      expect(find.text('Jumat, 13 Agu'), findsOneWidget); //Selected
      expect(find.text('Sabtu, 14 Agu'), findsOneWidget);
      expect(find.text('Minggu, 15 Agu'), findsOneWidget);
      expect(find.text('Senin, 16 Agu'), findsOneWidget);

      //Verify Drag Down Day
      await tester.drag(find.text('Kamis, 12 Agu'), _dragDown, warnIfMissed: false);
      expect(dateTime, DateTime(2021, 8, 23, 20, 10));
    });
  });
}
