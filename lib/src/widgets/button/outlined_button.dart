import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

enum OutlineType { rounded, circle }

class HOutlinedButton extends OutlinedButton {
  final String? text;
  final TextStyle? textStyle;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? radius;
  final double? borderWidth;
  final Color? textColor;
  final OutlineType? outlineType;

  HOutlinedButton({
    Key? key,
    this.text,
    this.textStyle,
    this.borderColor,
    required this.onPressed,
    Widget? child,
    this.backgroundColor,
    this.radius,
    this.borderWidth,
    this.textColor,
    this.outlineType = OutlineType.rounded,
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
            outlineType: outlineType,
          ),
          onPressed: onPressed,
        );

  static ButtonStyle outlinedButtonStyle({
    double? radius = 16,
    Color? borderColor,
    OutlineType? outlineType,
  }) {
    return OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 14),
        shape: outlineType == OutlineType.rounded
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 16),
              )
            : CircleBorder(),
        side: BorderSide(
          color: borderColor ?? HelperColors.orange,
        ));
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
    OutlineType? outlineType,
  }) =>
      _HOutlinedButtonWithIcon(
        onPressed: onPressed,
        icon: icon,
        borderColor: borderColor,
        outlineType: outlineType,
        text: text,
      );
}

class _HOutlinedButtonWithIcon extends HOutlinedButton {
  _HOutlinedButtonWithIcon({
    Key? key,
    String? text,
    required VoidCallback? onPressed,
    required Widget icon,
    OutlineType? outlineType,
    Color? borderColor,
  }) : super(
          key: key,
          onPressed: onPressed,
          outlineType: outlineType,
          borderColor: borderColor,
          child: text != null
              ? _OutlinedButtonWithIconChild(label: Text(text), icon: icon)
              : icon,
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
