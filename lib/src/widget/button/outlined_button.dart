import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class OutlinedButton extends BaseButton {
  final String text;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? radius;

  OutlinedButton({
    Key? key,
    required this.text,
    this.textStyle,
    this.borderColor,
    this.height,
    required this.onPressed,
    this.width,
    Widget? child,
    this.backgroundColor,
    this.radius,
  }) : super(
          key: key,
          backgroundColor: backgroundColor,
          borderColor: borderColor,
          onPressed: onPressed,
          isOutlinedButton: true,
          width: width,
          height: height,
          child: child,
          radius: radius,
        );

  factory OutlinedButton.icon({
    Key? key,
    required String text,
    TextStyle? textStyle,
    Color? borderColor,
    double? height,
    required VoidCallback onPressed,
    double? width,
    required Widget icon,
    final Color? backgroundColor,
    double? radius,
  }) = _OutlinedButtonWithIcon;

  @override
  Widget build(BuildContext context) {
    return _OutlineButton(
      text: text,
      textStyle: textStyle,
      borderColor: borderColor,
      height: height,
      width: width,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      radius: radius,
      child: child ?? Text(text, style: textStyle),
    );
  }
}

class _OutlinedButtonWithIcon extends OutlinedButton {
  _OutlinedButtonWithIcon({
    Key? key,
    required String text,
    TextStyle? textStyle,
    Color? borderColor,
    double? height,
    required VoidCallback? onPressed,
    double? width,
    required Widget icon,
    Color? backgroundColor,
    double? radius,
  }) : super(
          key: key,
          text: text,
          textStyle: textStyle,
          borderColor: borderColor,
          height: height,
          onPressed: onPressed,
          width: width,
          backgroundColor: backgroundColor,
          radius: radius,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              SizedBox(width: 4),
              Text(
                text, style: textStyle,
              )
            ],
          ),
        );
}

class _OutlineButton extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final Color? borderColor;
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final Widget? child;
  final Color? backgroundColor;
  final double? radius;

  const _OutlineButton({
    Key? key,
    this.text,
    this.textStyle,
    this.borderColor,
    this.height,
    this.width,
    this.onPressed,
    this.child,
    this.backgroundColor,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: onPressed,
      backgroundColor:
          backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
      borderColor: borderColor,
      width: width,
      height: height,
      isOutlinedButton: true,
      elevation: 0,
      child: child,
      radius: radius,
    );
  }
}
