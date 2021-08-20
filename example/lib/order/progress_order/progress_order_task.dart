import 'package:flutter/material.dart'
    hide OutlinedButton, Stepper, Step, StepState;
import 'package:helper_design/helper_design.dart';

import '../order.dart';

class ProgressOrderTask extends StatelessWidget {
  final OrderState? orderState;
  final bool withOutConfirmation;
  final VoidCallback? onChatPress;
  final VoidCallback? onConfirmationPress;

  const ProgressOrderTask({
    Key? key,
    this.orderState,
    this.withOutConfirmation = false,
    this.onChatPress,
    this.onConfirmationPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TaskModel> taskModel = TaskModel.getOrder();
    List<Step> steps = List.generate(
      3,
      (index) {
        return Step(
          indicatorColor: taskModel[index].orderState == OrderState.OnProgress
              ? HelperColors.orange
              : HelperColors.black9,
          lineColor: orderState == OrderState.FindingHelper
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
            borderColor: orderState == OrderState.FindingHelper
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
                    orderState == OrderState.FindingHelper
                        ? taskModel[index].orderState == OrderState.OnProgress
                            ? _body(taskModel[index].image,
                                taskModel[index].description)
                            : SizedBox()
                        : SizedBox(),
                  ],
                ),
              ),
              // Footer
              orderState == OrderState.FindingHelper
                  ? !withOutConfirmation
                      ? taskModel[index].orderState == OrderState.OnProgress
                          ? _footer(onChatPress ?? () {},
                              onConfirmationPress ?? () {})
                          : SizedBox()
                      : SizedBox()
                  : SizedBox(),
            ],
          ),
        );
      },
    );
    return StepView(steps: steps, stepViewType: StepViewType.vertical);
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
    ],
  );
}

Widget _footer(VoidCallback onChatPress, VoidCallback onConfirmationPress) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 13.0),
        child: DashLine(),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          HOutlinedButton.icon(
            height: 24.0,
            width: 71.0,
            onPressed: onChatPress,
            text: 'Chat',
            icon: Icon(
              Icons.chat_bubble_rounded,
              size: 13,
              color: HelperColors.orange,
            ),
          ),
          HOutlinedButton.icon(
            height: 24.0,
            width: 110.0,
            onPressed: onConfirmationPress,
            text: 'Konfirmasi',
            icon: Icon(
              Icons.check_circle_rounded,
              size: 13,
              color: HelperColors.orange,
            ),
          )
        ],
      ),
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
