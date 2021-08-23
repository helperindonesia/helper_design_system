import 'package:example/order/common/common.dart';
import 'package:flutter/material.dart'
    hide OutlinedButton, Stepper, Step, StepState;
import 'package:helper_design/helper_design.dart';

import '../order.dart';

class ProgressOrderView extends StatefulWidget {
  final OrderState? orderState;

  const ProgressOrderView({
    Key? key,
    this.orderState = OrderState.LookingHelper,
  }) : super(key: key);

  @override
  _ProgressOrderViewState createState() => _ProgressOrderViewState();
}

class _ProgressOrderViewState extends State<ProgressOrderView> {
  bool withOutConfirmation = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 16.0, right: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.orderState == OrderState.FindingHelper
                  ? Profile(
                      displayName: 'Abdur Razaq',
                      messageCount: 2,
                      withOutConfirmation: withOutConfirmation,
                      withOutConfirmationTogglePress: withOutConfirmationState,
                    )
                  : SizedBox(),
              ProgressOrderTask(
                orderState: widget.orderState,
                withOutConfirmation: withOutConfirmation,
                onChatPress: () {},
                onConfirmationPress: () {},
              ),
            ],
          ),
        ),
        Divider(thickness: 0.75, color: HelperColors.black10),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: PrimaryCard(onPressed: () {}),
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
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
                      .copyWith(fontWeight: FontWeight.w700, fontSize: 14.0),
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
    );
  }

  void withOutConfirmationState(bool newValue) {
    setState(() {
      withOutConfirmation = newValue;
    });
  }
}
