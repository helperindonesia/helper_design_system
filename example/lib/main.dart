import 'package:flutter/material.dart'
    hide OutlinedButton, Stepper, Step, StepState;
import 'package:helper_design/helper_design.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

  @override
  void initState() {
    super.initState();
  }

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
        appBar: AppBar(
          title: Text(widget.title, style: HelperThemeData.textTheme.headline5),
        ),
        body: Container(
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
                  action: PrimaryButton.icon(
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
            ],
          ),
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
            content: TextFieldWithExpansionView(
              labelText: 'adda',
              expansionTitle: 'abc',
              expansionChildren: [
                ...List.generate(3, (index) => Text('$index')),
              ],
            ),
          );
        case 1:
          return Step(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PrimaryButton(text: 'Ini Button', onPressed: () {}),
                PrimaryButton.icon(
                  text: 'Ini Button dgn Icon',
                  onPressed: () {},
                  icon: Icon(Icons.camera),
                )
              ],
            ),
          );
        default:
          return Step(
            lineColor: index > 0 ? HelperColors.black7 : null,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OutlinedButton(
                  onPressed: () {},
                  text: 'ABC',
                ),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    HelperIcons.edit,
                    color: HelperColors.orange,
                  ),
                  text: 'abc',
                )
              ],
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
