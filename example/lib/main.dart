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
        title: Text(widget.title,
            style: HelperThemeData.textTheme.bodyText3!
                .copyWith(color: HelperColors.orange2)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFieldJoinExpansionView(
              labelText: 'Apa kebutuhanmu?',
              expansionTitle: 'Bantu jelaskan dengan foto atau video',
              expansionChildren: [
                Text('Data 1'),
                Text('Data 1'),
                Text('Data 1')
              ],
            ),
            SizedBox(height: 20),
            OutlineTextField(
                labelText: 'Apa Kebutuhanmu?',
                textEditingController: myController),
            SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    OutlinedButton(
                      width: 80,
                      height: 24,
                      onPressed: () {},
                      text: 'Tambah',
                      textStyle: HelperThemeData.textTheme.subtitle2
                          ?.copyWith(color: HelperColors.orange),
                    ),
                    SizedBox(width: 20),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.edit,
                          size: 16, color: HelperColors.black3),
                      borderColor: HelperColors.black5,
                      text: 'Ubah',
                      textStyle: HelperThemeData.textTheme.subtitle2
                          ?.copyWith(color: HelperColors.black3),
                      width: 75,
                      height: 24,
                    ),
                    SizedBox(width: 20),
                  ],
                ),
                SizedBox(height: 20),
                PrimaryButton(
                  height: 48,
                  text: 'Tambah',
                  textStyle: HelperThemeData.textTheme.subtitle1
                      ?.copyWith(color: HelperColors.white),
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                PrimaryButton.icon(
                  textStyle: HelperThemeData.textTheme.subtitle1
                      ?.copyWith(color: HelperColors.white),
                  height: 48,
                  text: 'Lanjut',
                  icon: Icon(
                    HelperIcons.durasi,
                    size: 24,
                    color: HelperColors.white,
                  ),
                  onPressed: () {},
                ),
                SizedBox(height: 10),
                ExpansionView(
                  title: 'Bantu jelaskan dengan foto atau video',
                  children: [Text('Data 1'), Text('Data 1'), Text('Data 1')],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
