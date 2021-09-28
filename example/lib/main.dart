import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    hide OutlinedButton, Stepper, Step, StepState;
import 'package:helper_design/helper_design.dart';

import 'order/order.dart';

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
  double value = 25;
  var values = [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 60, 70, 80, 90, 100];

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
          body: Container(
            child: HSlider(
              minValue: 0,
              maxValue: 100,
              value: value,
              majorTick: 6,
              minorTick: 2,
              labelValuePrecision: 0,
              tickValuePrecision: 0,
              onChanged: (val) => setState(() {
                value = val;
                print(value);
              }),
              activeColor: Colors.orange,
              inactiveColor: Colors.orange.shade50,
              groupValues: values,
            ),
          )
          // Stack(
          //   fit: StackFit.expand,
          //   children: [
          //     Container(
          //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          //       width: MediaQuery.of(context).size.width,
          //       child: StepView(
          //         currentStep: currentStep,
          //         stepViewType: StepViewType.horizontal,
          //         steps: [
          //           ...List.generate(
          //             3,
          //             (i) => Step(
          //               title: 'Tahapan ${i + 1}',
          //               content: _buildContent(),
          //               action: PrimaryButton.icon(
          //                 height: 48,
          //                 text: 'Lanjutkan',
          //                 onPressed: () {
          //                   setState(() {
          //                     if (currentStep < 2) currentStep++;
          //                   });
          //                 },
          //                 icon: Icon(
          //                   Icons.chevron_right_rounded,
          //                   color: Colors.white,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ],
          // ),
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
                Card(
                  child: ExpansionView(
                    title: 'Membersihkan Kamar Mandi',
                    subtitle:
                        index < 2 ? 'Perumahan Apartemen Tidak Indah' : null,
                    children: [
                      ...List.generate(3, (index) => Text('$index')),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                PrimaryButton(
                  text: 'Show Swipe Button in Modal Bottom Sheet',
                  onPressed: () {
                    showModalBottomSheet<dynamic>(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return ModalBottomSheet(
                            withTopButton: false,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: ProfileCard(
                                  fullName: 'Abdur Razaq',
                                  rating: 3.0,
                                  onChatIconPressed: () {},
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: ProfileCard(
                                  fullName: 'Abdur Razaq',
                                  imageUrl:
                                      'https://cdn1-production-images-kly.akamaized.net/WrP9G-ttMc51fEkHtJtDysZ5OY8=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2329745/original/020818800_1534239405-7._Allkpop.jpg',
                                  rating: 3.0,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    color: HelperColors.red,
                                  ),
                                  footer: Container(
                                    margin: EdgeInsets.all(10),
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    color: HelperColors.green,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                child: ProfileCard.confirmation(
                                  onChatIconPressed: () {},
                                  fullName: 'Abdur Razaq',
                                  imageUrl:
                                      'https://cdn1-production-images-kly.akamaized.net/WrP9G-ttMc51fEkHtJtDysZ5OY8=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2329745/original/020818800_1534239405-7._Allkpop.jpg',
                                  rating: 3.0,
                                  value: true,
                                  onToggle: (_) {},
                                  child: Container(
                                    margin: EdgeInsets.only(top: 10),
                                    width: MediaQuery.of(context).size.width,
                                    height: 100,
                                    color: HelperColors.red,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                    top: 48.0, left: 48.0, right: 48.0),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        height: 148,
                                        image: NetworkImage(
                                          "https://cdn1-production-images-kly.akamaized.net/WrP9G-ttMc51fEkHtJtDysZ5OY8=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2329745/original/020818800_1534239405-7._Allkpop.jpg",
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 16.0),
                                    Text('Helper Sudah Siap, Ayo Mulai',
                                        style: HelperThemeData
                                            .textTheme.headline5),
                                    SizedBox(height: 2.0),
                                    Text(
                                      'Halo kakak, Saya sekarang sudah berada di toko amazon fresh',
                                      style: HelperThemeData
                                          .textTheme.bodyText3!
                                          .copyWith(color: HelperColors.black3),
                                    ),
                                    SizedBox(height: 20.0),
                                    PrimaryCard(
                                      title: 'Lihat Harga Dulu',
                                      description:
                                          'Penawaran harga dari Helpermu',
                                      onPressed: () {},
                                      buttonText: 'Lihat Penawaran Lain',
                                      buttonWidth: 168.0,
                                      backgroundColor: HelperColors.white,
                                      illustrationImage:
                                          'assets/images/illustration_lihat_harga.webp',
                                      illustrationHeight: 100.0,
                                      illustrationWidth: 153.0,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.0),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: PrimaryButton(
                                    text: 'Ok, Mulai',
                                    onPressed: () {
                                      Navigator.pop(context);
                                    }),
                              ),
                              SizedBox(height: 16.0),
                            ]);
                      },
                    );
                  },
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    HelperLabel(
                      text: 'Nego Berhasil',
                      backgroundColor: HelperColors.green,
                    ),
                    SizedBox(width: 10),
                    HelperLabel(
                      text: 'Nego Ditolak',
                      backgroundColor: HelperColors.red,
                    ),
                    SizedBox(width: 10),
                    HelperLabel(
                      text: 'Helpcash',
                      backgroundColor: HelperColors.orange,
                    ),
                  ],
                )
              ],
            ),
          );
        case 1:
          return Step(
              content: Column(
            children: [
              Slider(
                min: 0,
                max: 100,
                value: value,
                onChanged: (val) {
                  setState(() {
                    value = val;
                  });
                },
                divisions: value >= 50 ? 10 : 20,
                label: value.toString(),
              ),
              // HSlider()
            ],
          ));
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
                HOutlinedButton(
                  onPressed: () {},
                  text: 'ABC',
                ),
                HOutlinedButton.icon(
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
