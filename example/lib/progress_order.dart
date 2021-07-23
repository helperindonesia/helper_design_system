import 'dart:async';

import 'package:flutter/material.dart'
    hide OutlinedButton, Stepper, Step, StepState;
import 'package:helper_design/helper_design.dart';

enum OrderState {
  LookingHelper,
  FindingHelper,
  ToDo,
  OnProgress,
  onConfirmation
}

class ProgressOrder extends StatefulWidget {
  final OrderState? orderState;

  const ProgressOrder({Key? key, this.orderState = OrderState.LookingHelper})
      : super(key: key);

  @override
  _ProgressOrderState createState() => _ProgressOrderState();
}

class _ProgressOrderState extends State<ProgressOrder> {
  List<TaskModel> taskModel = TaskModel.getOrder();
  int currentStep = 0;
  late OrderState _orderState;

  @override
  void initState() {
    super.initState();
    _orderState = widget.orderState ?? OrderState.LookingHelper;
    Timer(Duration(seconds: 8), () {
      _orderState = OrderState.FindingHelper;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _orderState == OrderState.LookingHelper
              ? SafeArea(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 18.0, right: 18.0, top: 124.0, bottom: 4.0),
                          child: Stack(
                            children: [
                              Image(
                                image:
                                    AssetImage('assets/images/get_ready.png'),
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width,
                              ),
                              Positioned(
                                bottom: 4.0,
                                left: 30.0,
                                child: Text(
                                  'Helpermu Sedang Bersiap',
                                  style: HelperThemeData.textTheme.headline5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 48.0),
                          child: Text(
                            'Peralatan disediakan Helpermu akan dikenakan harga pemeliharaan alat.',
                            style: HelperThemeData.textTheme.bodyText3,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Image(
                  image: AssetImage('assets/images/profile.png'),
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
          Positioned(
            child: HelperAppBar.helpIcon(
                backgroundColor: Colors.transparent, elevation: 0),
          ),
          SafeArea(
            child: DraggableBottomSheet(
              initialChildSize: 0.12,
              minChildSize: 0.12,
              backgroundColor: HelperColors.white,
              child: Column(
                children: [
                  Container(
                    margin:
                        EdgeInsets.only(bottom: 16.0, left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _orderState == OrderState.FindingHelper
                            ? CardContainer(
                          margin: EdgeInsets.only(bottom: 16.0),
                                children: [
                                  CardContainer.horizontal(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    padding: EdgeInsets.fromLTRB(
                                        16.0, 12.0, 16.0, 16.0),
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Abdur Razaq',
                                            style: HelperThemeData
                                                .textTheme.bodyText1!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          SizedBox(height: 6.0),
                                          OutlinedButton(
                                            height: 24.0,
                                            width: 116.0,
                                            borderWidth: 0.75,
                                            borderColor: HelperColors.black,
                                            onPressed: () {},
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 14.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'Lihat Profile',
                                                    style: HelperThemeData
                                                        .textTheme.bodyText1!
                                                        .copyWith(
                                                            fontSize: 12.0,
                                                            color: HelperColors
                                                                .black3),
                                                  ),
                                                  Icon(
                                                    Icons.navigate_next_rounded,
                                                    size: 16.0,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      CircleIconButton(
                                        onPressed: () {},
                                        badgeCount: 1,
                                      )
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Tanpa Konfirmasi Tugas',
                                          style: HelperThemeData
                                              .textTheme.bodyText1!
                                              .copyWith(fontSize: 14.0),
                                        ),
                                        SwitchControl(
                                            value: false, onToggle: (bool) {})
                                      ],
                                    ),
                                  )
                                ],
                              )
                            : SizedBox(),
                        _buildContent()
                      ],
                    ),
                  ),
                  Divider(height: 0.75, color: HelperColors.black10),
                  CardContainer.horizontal(
                    radius: 12.0,
                    color: HelperColors.orange,
                    margin: EdgeInsets.all(16.0),
                    padding: EdgeInsets.all(12.0),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    border: Border(),
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              'Beri Tip Buat Helpermu',
                              style: HelperThemeData.textTheme.headline5!
                                  .copyWith(
                                      fontSize: 16.0,
                                      letterSpacing: 0.8 / 100,
                                      color: HelperColors.white),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: Text(
                              'Pastinya Helpermu merasa terbantu',
                              style: HelperThemeData.textTheme.caption!
                                  .copyWith(color: HelperColors.white),
                            ),
                          ),
                          SizedBox(height: 14.0),
                          OutlinedButton(
                            backgroundColor: Colors.transparent,
                            borderColor: HelperColors.white,
                            height: 24.0,
                            width: 80.0,
                            onPressed: () {},
                            text: 'Beri Tip',
                            textStyle: HelperThemeData.textTheme.buttonText1!
                                .copyWith(color: HelperColors.white),
                          )
                        ],
                      ),
                      Image(
                        image: AssetImage('assets/images/get_ready.png'),
                        fit: BoxFit.cover,
                        width: 40,
                        height: 40,
                      ),
                    ],
                  ),
                  CardContainer(
                    margin:
                        EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                    padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 13.0),
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Harga Tugas',
                              style: HelperThemeData.textTheme.caption!
                                  .copyWith(color: HelperColors.black5)),
                          Text(
                            'Rp 40.000 x 3 Jam',
                            style: HelperThemeData.textTheme.bodyText1!
                                .copyWith(fontSize: 14.0),
                          )
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pemeliharaan alat',
                            style: HelperThemeData.textTheme.caption!
                                .copyWith(color: HelperColors.black5),
                          ),
                          Text(
                            'Rp 20.000',
                            style: HelperThemeData.textTheme.bodyText1!
                                .copyWith(fontSize: 14.0),
                          )
                        ],
                      ),
                      SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Helpermu',
                            style: HelperThemeData.textTheme.caption!
                                .copyWith(color: HelperColors.black5),
                          ),
                          Text(
                            'x 2 Orang',
                            style: HelperThemeData.textTheme.bodyText1!
                                .copyWith(fontSize: 14.0),
                          )
                        ],
                      ),
                      SizedBox(height: 16.0),
                      DashLine(),
                      SizedBox(height: 13.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Bayar',
                            style: HelperThemeData.textTheme.bodyText1!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Rp 280.000',
                            style: HelperThemeData.textTheme.bodyText1!
                                .copyWith(fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: ExpansionView(
                      title: 'Helpcash',
                      leading: Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.payments_rounded,
                          size: 20.0,
                          color: HelperColors.orange,
                        ),
                      ),
                    ),
                  ),
                  SwipeButton(
                    onConfirmation: () {},
                    width: MediaQuery.of(context).size.width - 32.0,
                  ),
                  SizedBox(height: 16.0),
                  ToolTipsExtraTime(
                      text:
                          'Kamu bisa tambah waktu sekitar 30 menit per sekali penambahan. mau tambah waktu untuk tugasmu?',
                      onPressed: () {}),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Ada kendala dan mau ajukan pembatalan?',
                          style: HelperThemeData.textTheme.caption!
                              .copyWith(color: HelperColors.black5),
                        ),
                        OutlinedButton(
                          borderColor: HelperColors.black5,
                          height: 24.0,
                          width: 74.0,
                          onPressed: () {},
                          text: 'Ajukan',
                          textStyle: HelperThemeData.textTheme.buttonText1!
                              .copyWith(color: HelperColors.black3),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    List<Step> steps = List.generate(
      3,
      (index) {
        return Step(
          indicatorColor: taskModel[index].orderState == OrderState.OnProgress
              ? HelperColors.orange
              : HelperColors.black9,
          lineColor: _orderState == OrderState.FindingHelper
              ? taskModel[index].orderState == OrderState.OnProgress
                  ? HelperColors.orange
                  : HelperColors.black9
              : HelperColors.black9,
          indicatorIcon: index > 2
              ? Icon(
                  HelperIcons.plus,
                  color: HelperColors.white,
                )
              : null,
          content: CardContainer(
            width: MediaQuery.of(context).size.width,
            borderColor: _orderState == OrderState.FindingHelper
                ? taskModel[index].orderState == OrderState.OnProgress
                    ? HelperColors.orange
                    : HelperColors.black10
                : HelperColors.black10,
            padding:
                EdgeInsets.only(top: 14.0, bottom: 12, left: 12.0, right: 12.0),
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Header
                    _header(taskModel[index].title, taskModel[index].address),
                    //Body
                    _orderState == OrderState.FindingHelper
                        ? taskModel[index].orderState == OrderState.OnProgress
                            ? _body(taskModel[index].image,
                                taskModel[index].description)
                            : SizedBox()
                        : SizedBox(),
                  ],
                ),
              ),
              //Footer
              _orderState == OrderState.FindingHelper
                  ? taskModel[index].orderState == OrderState.OnProgress
                      ? _footer(() {}, () {})
                      : SizedBox()
                  : SizedBox()
            ],
          ),
        );
      },
    );

    return StepView(
      steps: steps,
      stepViewType: StepViewType.vertical,
    );
  }
}

Widget _header(String? title, String? address) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title ?? 'No Title',
        style: HelperThemeData.textTheme.bodyText1!
            .copyWith(fontWeight: FontWeight.w700),
      ),
      Text(
        address ?? 'No Address',
        style: HelperThemeData.textTheme.caption!
            .copyWith(color: HelperColors.black5),
      ),
    ],
  );
}

Widget _body(String? mediaUrl, String? description) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 16.0),
      Row(
        children: [
          MediaThumbnail(
            onPressed: () {},
            mediaUrl: mediaUrl ??
                'https://helperid.com/wp-content/uploads/2020/07/helper.png',
          ),
          SizedBox(width: 16.0),
          Expanded(
              child: Text(
            description ?? 'No Description',
            style: HelperThemeData.textTheme.caption!
                .copyWith(color: HelperColors.black),
          ))
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 13.0),
        child: DashLine(),
      ),
    ],
  );
}

Widget _footer(VoidCallback? onChatPress, VoidCallback? onConfirmationPress) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      OutlinedButton.icon(
        height: 24.0,
        width: 71.0,
        onPressed: () {},
        text: 'Chat',
        icon: Icon(
          Icons.chat_bubble_rounded,
          size: 13,
          color: HelperColors.orange,
        ),
      ),
      OutlinedButton.icon(
        height: 24.0,
        width: 110.0,
        onPressed: () {},
        text: 'Konfirmasi',
        icon: Icon(
          Icons.check_circle_rounded,
          size: 13,
          color: HelperColors.orange,
        ),
      )
    ],
  );
}

class TaskModel {
  String? title;
  String? address;
  String? image;
  String? description;
  OrderState? orderState;

  TaskModel(
      {this.title,
      this.address,
      this.image,
      this.description,
      this.orderState});

  static List<TaskModel> getOrder() {
    return <TaskModel>[
      TaskModel(
          title: 'Ambil Kunci di Rumah Nenek',
          address: 'Jl. Perintis Kemerdekaan IV',
          image:
              'https://cdn1-production-images-kly.akamaized.net/WrP9G-ttMc51fEkHtJtDysZ5OY8=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2329745/original/020818800_1534239405-7._Allkpop.jpg',
          description:
              'Saya sudah membersihkan halaman rumah Bapak dan sekarang bersiap untuk antar kuncinya ke Bapak.',
          orderState: OrderState.OnProgress),
      TaskModel(
          title: 'Belanja Sayur di Pasar Terong',
          address: 'Jl. Gunung Bawakaraeng',
          image:
              'https://cdn1-production-images-kly.akamaized.net/WrP9G-ttMc51fEkHtJtDysZ5OY8=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2329745/original/020818800_1534239405-7._Allkpop.jpg',
          description:
              'Saya sudah membersihkan halaman rumah Bapak dan sekarang bersiap untuk antar kuncinya ke Bapak.',
          orderState: OrderState.ToDo),
      TaskModel(
          title: 'Antar Kunci ke Rumah Saya',
          address: 'Jl. Hertasning Baru',
          image:
              'https://cdn1-production-images-kly.akamaized.net/WrP9G-ttMc51fEkHtJtDysZ5OY8=/640x360/smart/filters:quality(75):strip_icc():format(jpeg)/kly-media-production/medias/2329745/original/020818800_1534239405-7._Allkpop.jpg',
          description:
              'Saya sudah membersihkan halaman rumah Bapak dan sekarang bersiap untuk antar kuncinya ke Bapak.',
          orderState: OrderState.ToDo),
    ];
  }
}
