import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final String? time;
  final TextStyle? timeStyle;
  final bool isSend;
  final Color? sendBackgroundColor;
  final Color? receiveBackgroundColor;
  final IconData? icon;
  final double? iconSize;
  final bool isRead;
  final double? maxWidth;

  const ChatBubble({
    Key? key,
    required this.text,
    this.textStyle,
    this.time,
    this.timeStyle,
    this.isSend = false,
    this.sendBackgroundColor,
    this.receiveBackgroundColor,
    this.icon,
    this.iconSize,
    this.isRead = false,
    this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
      decoration: ShapeDecoration(
          color: isSend
              ? sendBackgroundColor ?? HelperColors.orange10
              : receiveBackgroundColor ?? HelperColors.black10,
          shape: isSend
              ? ChatBubbleShapeBorder(isSend: true)
              : ChatBubbleShapeBorder(isSend: false)),
      child: Stack(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 13.0, horizontal: 16.0),
            child: RichText(
              text: TextSpan(
                children: <TextSpan>[
                  //real message
                  TextSpan(
                    text: text + "    ",
                    style: HelperThemeData.textTheme.bodyText3!
                        .copyWith(color: HelperColors.black),
                  ),

                  //fake additionalInfo as placeholder
                  TextSpan(
                    text: time ?? '12:00',
                    style: TextStyle(color: Colors.transparent),
                  ),
                ],
              ),
            ),
          ),
          //real additionalInfo
          Positioned(
            right: 8.0,
            bottom: 12.0,
            child: Row(
              children: [
                Text(
                  time ?? '12:00',
                  style: timeStyle ??
                      HelperThemeData.textTheme.caption!
                          .copyWith(color: HelperColors.black8),
                ),
                SizedBox(width: 8.0),
                Icon(
                  icon ?? Icons.done_all_rounded,
                  size: iconSize ?? 16.0,
                  color: isRead ? HelperColors.green : HelperColors.black8,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
