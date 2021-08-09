import 'package:example/order/common/common.dart';
import 'package:example/order/order.dart';
import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class OrderFinishView extends StatelessWidget {
  final OrderState orderState;
  final VoidCallback onPressed;

  const OrderFinishView(
      {Key? key,
      this.orderState = OrderState.FindingHelper,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OrderFinishStatus(
          text: orderState == OrderState.Cancel ? 'Dibatalkan' : 'Selesai',
          backgroundColor: orderState == OrderState.Cancel
              ? HelperColors.red
              : HelperColors.green,
        ),
        Container(
          padding: const EdgeInsets.only(top: 16.0, left: 16.0, bottom: 16.0, right: 8.0),
          child: Column(
            children: [
              Profile(
                negotiationSuccess: false,
                profileType: ProfileType.WithPriceAndNegotiation,
                afterNegotiation: true,
                displayName: 'Abdur Razaq',
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  children: [
                    ProgressOrderTask(),
                    orderState == OrderState.Done
                        ? DetailPrice(
                      orderState: orderState,
                    )
                        : SizedBox(),
                    orderState == OrderState.Cancel
                        ? PrimaryCard(onPressed: () {})
                        : SizedBox(),
                    SizedBox(height: 16.0),
                    PrimaryButton(
                      height: 48.0,
                      text: 'Ok, Tutup',
                      onPressed: onPressed,
                      backgroundColor: HelperColors.black10,
                      textStyle: HelperThemeData.textTheme.buttonText1!
                          .copyWith(color: HelperColors.black3),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
