import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class CircleIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final double height;
  final double width;
  final int badgeCount;
  final TextStyle? badgeStyle;
  final double? badgeFontSize;

  const CircleIconButton(
      {Key? key,
      required this.onPressed,
      this.icon,
      this.iconColor,
      this.iconSize,
      this.height = 40.0,
      this.width = 40.0,
      this.badgeCount = 0,
      this.badgeStyle,
      this.badgeFontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: badgeCount > 0 ? width + 6.0 : width,
      height: badgeCount > 0 ? height + 8.0 : height,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            child: BaseButton(
              radius: width,
              onPressed: onPressed,
              height: height,
              width: width,
              child: Icon(
                icon ?? Icons.chat_bubble_rounded,
                size: iconSize ?? 20.0,
                color: iconColor ?? HelperColors.white,
              ),
            ),
          ),
          if (badgeCount > 0)
            Positioned(
              top: 0,
              right: 0,
              child: InkWell(
                onTap: onPressed,
                child: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: HelperColors.white),
                  child: Container(
                    padding: badgeCount > 9
                        ? EdgeInsets.all(2)
                        : EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: HelperColors.red,
                    ),
                    child: Text(
                      '$badgeCount',
                      style: HelperThemeData.textTheme.bodyText1!.copyWith(
                          color: HelperColors.white,
                          fontSize: badgeFontSize ?? 12.0),
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
