import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  group('Helper App Bar Test', () {
    testWidgets('Helper App Bar', (WidgetTester tester) async {
      bool? _value;

      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          appBar: HelperAppBar(
            leading: Icon(Icons.arrow_back_rounded),
            onBackPressed: () {
              _value = true;
            },
          ),
        ),
      ));

      //Verify Widget
      expect(_value, isNull);
      expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);

      //Tap backPress (Icons.arrow_back_rounded)
      await tester.tap(find.byIcon(Icons.arrow_back_rounded));

      //Verify after tap Icon
      expect(_value, isTrue);
    });

    testWidgets('Helper App Bar With Image', (WidgetTester tester) async {
      bool? _value;
      Widget makeTestableWidget() {
        return MaterialApp(
          home: Scaffold(
            appBar: HelperAppBar.image(
              name: 'My Name',
              leadingIcon: Icons.arrow_back_rounded,
              onBackPressed: () {
                _value = true;
              },
              mediaUrl:
                  'https://cdn1-production-images-kly.akamaized.net/WrP9G-ttMc51fEkHtJtDysZ5OY8=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2329745/original/020818800_1534239405-7._Allkpop.jpg',
            ),
          ),
        );
      }

      await mockNetworkImagesFor(() => tester.pumpWidget(makeTestableWidget()));

      //Verify Widget
      expect(_value, isNull);
      expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
      expect(find.text('My Name'), findsOneWidget);
      expect(find.byType(MediaThumbnail), findsOneWidget);

      //Tap backPress (Icons.arrow_back_rounded)
      await tester.tap(find.byIcon(Icons.arrow_back_rounded));

      //Verify Value after tap Icon
      expect(_value, isTrue);
    });

    testWidgets('Helper App Bar With Help Icon', (WidgetTester tester) async {
      bool? _backPressValue;
      bool? _helpPressValue;
      Widget makeTestableWidget() {
        return MaterialApp(
          home: Scaffold(
            appBar: HelperAppBar.helpIcon(
              title: 'My Name',
              leadingIcon: Icons.arrow_back_rounded,
              onBackPressed: () {
                _backPressValue = true;
              },
              onHelpPressed: () {
                _helpPressValue = true;
              },
            ),
          ),
        );
      }

      await tester.pumpWidget(makeTestableWidget());

      //Verify Widget
      expect(_backPressValue, isNull);
      expect(_helpPressValue, isNull);
      expect(find.byIcon(Icons.help), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
      expect(find.text('My Name'), findsOneWidget);

      //Tap backPress (Icons.arrow_back_rounded)
      await tester.tap(find.byIcon(Icons.arrow_back_rounded));

      //Verify Value after tap backPress
      expect(_backPressValue, isTrue);

      //Tap HelpIcon
      await tester.tap(find.byIcon(Icons.help));

      //Verify Value after helpIconPress
      expect(_helpPressValue, isTrue);
    });
  });
}
