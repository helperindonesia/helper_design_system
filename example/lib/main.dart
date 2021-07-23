import 'package:example/progress_order.dart';
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
      ProgressOrder()
      // MyHomePage(title: 'Helper Design Example'),
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
        appBar: HelperAppBar.image(
          name: 'Help Asisten',
          mediaUrl:
              'https://cdn1-production-images-kly.akamaized.net/WrP9G-ttMc51fEkHtJtDysZ5OY8=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2329745/original/020818800_1534239405-7._Allkpop.jpg',
        ),
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
            DraggableBottomSheet(
              initialChildSize: 0.1,
              backgroundColor: Colors.red,
              child: Column(
                children: _buildHelper(50),
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
              children: [
                TextFieldWithExpansionView(
                  labelText: 'adda',
                  expansionTitle: 'abc',
                  expansionChildren: [
                    ...List.generate(3, (index) => Text('$index')),
                  ],
                ),
                SizedBox(height: 10),
                PrimaryButton(
                  text: 'Show Swipe Button in Modal Bottom Sheet',
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return ModalBottomSheet(children: [
                          SizedBox(height: 25.0),
                          SwipeButton(
                              // disable: true,
                              height: 48.0,
                              width: MediaQuery.of(context).size.width - 30,
                              onConfirmation: () {
                                print('onConfirmation');
                              }),
                          SizedBox(height: 50.0),
                          ChatBoxContainer(onSendTap: () {})
                        ]);
                      },
                    );
                  },
                )
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
                ),
                CardContainer(
                  padding: EdgeInsets.all(12.0),
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 1.0, left: 4.0, bottom: 2.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Ambil Barang di Kota",
                            style: HelperThemeData.textTheme.buttonText1!
                                .copyWith(color: HelperColors.black),
                          ),
                          Icon(
                            Icons.drag_handle,
                            color: HelperColors.black8,
                            size: 24.0,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Text(
                        'Jln. Perintis Kemerdekaan',
                        style: HelperThemeData.textTheme.caption!
                            .copyWith(color: HelperColors.black5),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 14.0),
                        child:
                            Divider() //TODO: Change Divider to DashLine after Merge
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton.icon(
                          borderColor: HelperColors.black5,
                          width: 82,
                          height: 24,
                          onPressed: () {},
                          text: 'Hapus',
                          textStyle: HelperThemeData.textTheme.buttonText2!
                              .copyWith(color: HelperColors.black3),
                          icon: Icon(
                            Icons.remove_circle_rounded,
                            size: 16.0,
                            color: HelperColors.black3,
                          ),
                        ),
                        OutlinedButton.icon(
                          borderColor: HelperColors.black5,
                          width: 82,
                          height: 24,
                          onPressed: () {},
                          text: 'Hapus',
                          textStyle: HelperThemeData.textTheme.buttonText2!
                              .copyWith(color: HelperColors.black3),
                          icon: Icon(
                            Icons.edit,
                            size: 16.0,
                            color: HelperColors.black3,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: ShapeDecoration(shape: ToolTipsShapeBorder()),
                )
              ],
            ),
          );
        case 2:
          return Step(
            content: Column(
              children: [
                Row(
                  children: [
                    MediaThumbnail(
                      margin: EdgeInsets.all(5),
                      mediaUrl:
                          "https://cdn1-production-images-kly.akamaized.net/WrP9G-ttMc51fEkHtJtDysZ5OY8=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2329745/original/020818800_1534239405-7._Allkpop.jpg",
                    ),
                    MediaThumbnail(
                      mediaType: MediaType.video,
                      margin: EdgeInsets.all(5),
                      mediaUrl:
                          "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_20mb.mp4",
                    ),
                    MediaThumbnail(
                      isWithIcon: true,
                      mediaType: MediaType.image,
                      margin: EdgeInsets.all(5),
                      mediaUrl:
                          "https://cdn1-production-images-kly.akamaized.net/WrP9G-ttMc51fEkHtJtDysZ5OY8=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2329745/original/020818800_1534239405-7._Allkpop.jpg",
                    ),
                  ],
                ),
                Container(
                  height: 10,
                  width: 200,
                  child: DashLine(color: HelperColors.orange),
                ),
                DashBorder.iconWithText(onPressed: () {}),
                SizedBox(height: 10),
                ToolTipsExtraTime(
                    onPressed: () {},
                    text:
                        'Kamu bisa tambah waktu sekitar 30 menit per sekali penambahan, mau tambah waktu untuk tugasmu?'),
                SizedBox(height: 10),
                ChatBubble(
                    typeMessage: TypeMessage.Receiver,
                    text:
                        'Pak saya sudah ada didepan tapi saya lihat pintu masih tertutup pak apakah ada orang?'),
                SizedBox(height: 10),
                ChatBubble(
                    isRead: true, text: 'Pak saya sudah ada didepan tapi'),
                SizedBox(height: 10),
                CircleIconButton(
                  onPressed: () {},
                  badgeCount: 1,
                ),
                SizedBox(height: 10),
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

List<Widget> _buildHelper(int value) {
  var helper = <Widget>[];
  helper.add(Text("Helpers"));

  for (var i = 0; i < value; i++) {
    helper.add(Text("Helper " + i.toString()));
  }

  return helper;
}
