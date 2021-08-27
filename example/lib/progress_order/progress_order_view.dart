import 'dart:async';

import 'package:example/progress_order/detail_price.dart';
import 'package:example/progress_order/profile.dart';
import 'package:example/progress_order/progress_order.dart';
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
  int currentStep = 0;
  late OrderState _orderState;
  bool withOutConfirmation = false;

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
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _orderState == OrderState.FindingHelper
                            ? Profile(
                                displayName: 'Abdur Razaq',
                                messageCount: 2,
                                withOutConfirmation: withOutConfirmation,
                                withOutConfirmationTogglePress:
                                    withOutConfirmationState,
                              )
                            : SizedBox(),
                        Task(
                          orderState: _orderState,
                          withOutConfirmation: withOutConfirmation,
                          onChatPress: () {},
                          onConfirmationPress: () {},
                        ),
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
                          HOutlinedButton(
                            borderColor: HelperColors.white,
                            onPressed: () {},
                            text: 'Beri Tip',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DetailPrice(
                      taskCost: 'Rp 40.000 x 3 Jam',
                      toolCost: 'Rp 20.000',
                      helperCount: 'x 2 Orang',
                      totalCost: 'Rp 280.000',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 14.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.payments_rounded,
                          size: 20.0,
                          color: HelperColors.orange,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Helpcash',
                            style: HelperThemeData.textTheme.bodyText1!
                                .copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0),
                          ),
                        ),
                        Icon(
                          Icons.pending_rounded,
                          size: 20.0,
                          color: HelperColors.black3,
                        )
                      ],
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
                        HOutlinedButton(
                          borderColor: HelperColors.black5,
                          onPressed: () {},
                          text: 'Ajukan',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void withOutConfirmationState(bool newValue) {
    setState(() {
      withOutConfirmation = newValue;
    });
  }
}
