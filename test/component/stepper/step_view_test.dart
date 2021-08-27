import 'package:flutter/material.dart' hide Step;
import 'package:flutter_test/flutter_test.dart';
import 'package:helper_design/helper_design.dart';

void main() {
  group('Step View', () {
    testWidgets('Step View 1,2,3 Test', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(StepViewTest());

      //Verify Widget in Step 1
      expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
      expect(find.text('Step 1'), findsWidgets);
      expect(find.text('Step 2'), findsNothing);
      expect(find.text('Step 3'), findsNothing);

      //Tap icon to Next Step
      await tester.tap(find.byIcon(Icons.chevron_right_rounded));
      await tester.pumpAndSettle();

      //Verify Widget in Step 2
      expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
      expect(find.text('Step 1'), findsNothing);
      expect(find.text('Step 2'), findsWidgets);
      expect(find.text('Step 3'), findsNothing);

      //Tap Icon to Next Step
      await tester.tap(find.byIcon(Icons.chevron_right_rounded));
      await tester.pumpAndSettle();

      //Verify Widget in Step 3
      expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
      expect(find.text('Step 1'), findsNothing);
      expect(find.text('Step 2'), findsNothing);
      expect(find.text('Step 3'), findsWidgets);

      //Tap onBackPress
      await tester.tap(find.byIcon(Icons.arrow_back_rounded));
      await tester.pumpAndSettle();

      //Verify Widget in Step 2
      expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
      expect(find.text('Step 3'), findsNothing);
      expect(find.text('Step 2'), findsWidgets);
      expect(find.text('Step 1'), findsNothing);

      //Tap onBackPress
      await tester.tap(find.byIcon(Icons.arrow_back_rounded));
      await tester.pumpAndSettle();

      //Verify Widget in Step 1
      expect(find.byIcon(Icons.arrow_back_rounded), findsOneWidget);
      expect(find.text('Step 3'), findsNothing);
      expect(find.text('Step 2'), findsNothing);
      expect(find.text('Step 1'), findsWidgets);
    });
  });
}

class StepViewTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: HelperThemeData.themeData(),
      home: MyHomePage(title: 'Helper Design Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentStep = 0;

  Future<bool> _onWillPop() async {
    if (currentStep > 0 && currentStep <= 2) {
      setState(() {
        currentStep--;
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: HelperAppBar(leading: Icon(Icons.arrow_back_rounded), onBackPressed: _onWillPop),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              width: MediaQuery.of(context).size.width,
              child: StepView(
                currentStep: currentStep,
                stepViewType: StepViewType.horizontal,
                steps: [
                  ...List.generate(
                    3,
                    (i) => Step(
                      title: 'Tahapan ${i + 1}',
                      content: _buildContent(),
                      action: Padding(
                        padding: const EdgeInsets.only(bottom: 70),
                        child: PrimaryButton.icon(
                          height: 48,
                          text: 'Lanjutkan',
                          onPressed: () {
                            setState(() {
                              if (currentStep < 2) currentStep++;
                            });
                          },
                          icon: Icon(
                            Icons.chevron_right_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    List<Step> steps = List.generate(3, (index) {
      switch (currentStep) {
        case 0:
          return Step(
            indicatorIcon: index > 1
                ? Icon(
                    HelperIcons.plus,
                    color: HelperColors.white,
                  )
                : null,
            content: Column(
              children: [Text('Step 1')],
            ),
          );
        case 1:
          return Step(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Step 2')],
            ),
          );
        case 2:
          return Step(
            content: Column(
              children: [Text('Step 3')],
            ),
          );
        default:
          return Step(
            lineColor: index > 0 ? HelperColors.black7 : null,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('Step')],
            ),
          );
      }
    });

    return StepView(
      steps: steps,
      stepViewType: StepViewType.vertical,
    );
  }
}
