import 'package:flutter/material.dart'
    hide OutlinedButton, Stepper, Step, StepState;
import 'package:helper_design/helper_design.dart';

class Profile extends StatelessWidget {
  final String? displayName;
  final int? messageCount;
  final ValueChanged<bool>? onTogglePress;
  final bool? isAvailable;

  const Profile({
    Key? key,
    this.displayName,
    this.messageCount,
    this.isAvailable,
    this.onTogglePress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      margin: EdgeInsets.only(bottom: 16.0),
      children: [
        CardContainer.horizontal(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 16.0),
          children: [
            Column(
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
                          style: HelperThemeData.textTheme.bodyText1!.copyWith(
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
            CircleIconButton(
              onPressed: () {},
              badgeCount: messageCount ?? 0,
            )
          ],
        ),
        Container(
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
                  value: isAvailable ?? false,
                  onToggle: onTogglePress ?? (bool) {})
            ],
          ),
        )
      ],
    );
  }
}
