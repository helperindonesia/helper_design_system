import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HOutlinedButton extends OutlinedButton {
  final String? text;
  final TextStyle? textStyle;
  final Color? borderColor;

  // final double? height;
  // final double? width;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? radius;
  final double? borderWidth;
  final Color? textColor;

  HOutlinedButton({
    Key? key,
    this.text,
    this.textStyle,
    this.borderColor,
    // this.height,
    required this.onPressed,
    // this.width,
    Widget? child,
    this.backgroundColor,
    this.radius,
    this.borderWidth,
    this.textColor,
  }) : super(
          key: key,
          child: child ??
              Text(
                text ?? '',
                style: HelperThemeData.textTheme.buttonText2
                    ?.copyWith(color: HelperColors.orange),
              ),
          style: outlinedButtonStyle(
            radius: radius,
            borderColor: borderColor,
          ),
          // backgroundColor: backgroundColor,
          // borderColor: borderColor,
          onPressed: onPressed,
          // isOutlinedButton: true,
          // width: width,
          // height: height,
          // child: child,
          // radius: radius,
          // borderWidth: borderWidth,
        );

  static ButtonStyle outlinedButtonStyle(
      {double? radius = 16, Color? borderColor}) {
    return OutlinedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 14),
      textStyle: HelperThemeData.textTheme.buttonText2
          ?.copyWith(color: HelperColors.orange),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 16),
      ),
      side: BorderSide(
        color: borderColor ?? HelperColors.orange,
      ),
    );
  }

  factory HOutlinedButton.icon({
    Key? key,
    String? text,
    TextStyle? textStyle,
    Color? borderColor,
    double? height,
    required VoidCallback onPressed,
    double? width,
    required Widget icon,
    Color? backgroundColor,
    double? radius,
    double? borderWidth,
    Color? textColor,
  }) =>
      _HOutlinedButtonWithIcon(
        onPressed: onPressed,
        icon: icon,
      );
}

class _HOutlinedButtonWithIcon extends HOutlinedButton {
  _HOutlinedButtonWithIcon({
    Key? key,
    String? text,
    TextStyle? textStyle,
    Color? borderColor,
    // double? height,
    required VoidCallback? onPressed,
    // double? width,
    required Widget icon,
    Color? backgroundColor,
    double? radius,
    double? borderWidth,
    Color? textColor,
  }) : super(
          key: key,
          onPressed: onPressed,
          child:
              _OutlinedButtonWithIconChild(label: Text(text ?? ''), icon: icon),
        );
}

class _OutlinedButtonWithIconChild extends StatelessWidget {
  const _OutlinedButtonWithIconChild({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), label],
    );
  }
}
