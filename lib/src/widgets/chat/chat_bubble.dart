import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final TypeMessage? typeMessage;
  final TextStyle? textStyle;
  final String? time;
  final TextStyle? timeStyle;
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
    this.typeMessage = TypeMessage.Sender,
    this.sendBackgroundColor,
    this.receiveBackgroundColor,
    this.icon,
    this.iconSize,
    this.isRead = false,
    this.maxWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mainPaddingRight = 16.0;
    double mainPaddingLeft = 16.0;

    if (typeMessage == TypeMessage.Sender) {
      mainPaddingRight = 16.0;
      mainPaddingLeft = 70.0;
    } else {
      mainPaddingRight = 70.0;
      mainPaddingLeft = 16.0;
    }

    return Container(
      margin: EdgeInsets.only(left: mainPaddingLeft, right: mainPaddingRight, top: 24.0),
      decoration: ShapeDecoration(
        color: typeMessage == TypeMessage.Sender
            ? sendBackgroundColor ?? HelperColors.orange10
            : receiveBackgroundColor ?? HelperColors.black10,
        shape: typeMessage == TypeMessage.Sender
            ? ChatBubbleShapeBorder(typeMessage: TypeMessage.Sender)
            : ChatBubbleShapeBorder(typeMessage: TypeMessage.Receiver),
      ),
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
