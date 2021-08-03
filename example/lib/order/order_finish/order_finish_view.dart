import 'package:example/order/common/common.dart';
import 'package:example/order/order.dart';
import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class OrderFinishView extends StatelessWidget {
  final OrderState orderState;
  final VoidCallback onPressed;

  const OrderFinishView(
      {Key? key, this.orderState = OrderState.Done, required this.onPressed})
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
          margin: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Profile(
                orderState: OrderState.Done,
                displayName: 'Abdur Razaq',
              ),
              ProgressOrderTask(),
              orderState == OrderState.Done
                  ? DetailPrice(
                      orderState: orderState,
                    )
                  : SizedBox(),
              orderState == OrderState.Cancel
                  ? TipCard(onPressed: () {})
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
    );
  }
}
