import 'package:flutter/cupertino.dart';
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
      home:
          // OrderView()
          MyHomePage(title: 'Helper Design Example'),
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
  double value = 0;
  double value1 = 0;
  List<double> values = [
    // 0,
    5,
    10,
    15,
    20,
    25,
    30,
    35,
    40,
    45,
    50,
    60,
    70,
    80,
    90,
    100
  ];

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
    double _returnValue(double value) {
      double result = ((value * 15) / 100);
      // print('index ${result.round()}');
      return values[result.round().toInt()].toDouble();
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: HelperAppBar.image(
          name: 'Help Asisten',
          mediaUrl:
              'https://cdn1-production-images-kly.akamaized.net/WrP9G-ttMc51fEkHtJtDysZ5OY8=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2329745/original/020818800_1534239405-7._Allkpop.jpg',
        ),
        body: Column(
          children: [
            HSlider(
              label: value.toString(),
              value: value,
              values: values,
              onChanged: (val) {
                setState(() {
                  value = val;
                  print('Actual Value : $value');
                  // print('Expect Value ${_returnValue(value)}');
                });
              },
            ),
            Slider(
              value: value1,
              onChanged: (double val) {
                setState(() {
                  value1 = val;
                  // print(_returnValue(value1));
                  print(value1);
                });
              },
              min: 0,
              max: 100,
              divisions: 15,
              label: _returnValue(value1).toString(),
            ),
          ],
        ),
      ),
    );
  }
}
