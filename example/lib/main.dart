import 'package:flutter/material.dart' hide OutlinedButton;
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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  TextEditingController myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            OutlineTextField(
                labelText: 'Apa Kebutuhanmu?',
                textEditingController: myController),
            SizedBox(height: 20),
            OutlineTextField(
              labelText: 'Apa Kebutuhanmu?',
              trailing: Icon(
                Icons.mic,
                color: HelperColors.black9,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                OutlinedButton(
                  width: 80,
                  height: 24,
                  onPressed: () {},
                  text: 'Tambah',
                  textStyle: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(color: HelperColors.orange),
                ),
                SizedBox(width: 20),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.edit, size: 16, color: HelperColors.black3),
                  borderColor: HelperColors.black5,
                  text: 'Ubah',
                  textStyle: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(color: HelperColors.black3),
                  width: 75,
                  height: 24,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
