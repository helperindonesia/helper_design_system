import 'package:example/order/order.dart';
import 'package:flutter/material.dart'
    hide OutlinedButton, Stepper, Step, StepState;
import 'package:helper_design/helper_design.dart';

class Profile extends StatelessWidget {
  final String? displayName;
  final int? messageCount;
  final ValueChanged<bool>? withOutConfirmationTogglePress;
  final bool? withOutConfirmation;
  final OrderState orderState;

  const Profile({
    Key? key,
    this.displayName,
    this.messageCount,
    this.withOutConfirmation,
    this.withOutConfirmationTogglePress,
    this.orderState = OrderState.OnConfirmation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      margin: EdgeInsets.only(bottom: 16.0),
      children: [
        CardContainer.horizontal(
          mainAxisAlignment: MainAxisAlignment.start,
          padding: EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 16.0),
          children: [
            orderState == OrderState.Done || orderState == OrderState.Cancel
                ? Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset(
                          'assets/images/profile.png',
                          height: 56.0,
                          width: 52.0,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(width: 16.0),
                    ],
                  )
                : SizedBox(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName ?? 'No Name',
                    style: HelperThemeData.textTheme.bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 6.0),
                  OutlinedButton(
                    height: 24.0,
                    width: 116.0,
                    borderWidth: 0.75,
                    borderColor: HelperColors.black,
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lihat Profile',
                            style: HelperThemeData.textTheme.bodyText1!
                                .copyWith(
                                    fontSize: 12.0, color: HelperColors.black3),
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
            ),
            orderState == OrderState.Done || orderState == OrderState.Cancel
                ? SizedBox()
                : CircleIconButton(
                    onPressed: () {},
                    badgeCount: messageCount ?? 0,
                  )
          ],
        ),
        orderState == OrderState.Done || orderState == OrderState.Cancel
            ? SizedBox()
            : Container(
                padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tanpa Konfirmasi Tugas',
                      style: HelperThemeData.textTheme.bodyText1!
                          .copyWith(fontSize: 14.0),
                    ),
                    SwitchControl(
                        value: withOutConfirmation ?? false,
                        onToggle: withOutConfirmationTogglePress ?? (bool) {})
                  ],
                ),
              )
      ],
    );
  }
}
