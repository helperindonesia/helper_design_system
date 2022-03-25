import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class PrimaryButton extends BaseButton {
  final String text;
  final TextStyle? textStyle;
  final double? width;
  final double? height;
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final double? radius;

  const PrimaryButton({
    Key? key,
    required this.text,
    this.textStyle,
    this.width,
    required this.onPressed,
    Widget? child,
    this.height = 48.0,
    this.backgroundColor = HelperColors.orange,
    this.radius,
  }) : super(
          key: key,
          onPressed: onPressed,
          height: height,
          width: width,
          backgroundColor: backgroundColor,
          radius: radius,
          child: child,
        );

  factory PrimaryButton.icon({
    Key? key,
    required String text,
    TextStyle? textStyle,
    double? width,
    double? height,
    required VoidCallback? onPressed,
    Color backgroundColor,
    double? radius,
    required Widget icon,
  }) = _PrimaryButtonWithIcon;

  @override
  Widget build(BuildContext context) {
    return _PrimaryButton(
      width: width ?? MediaQuery.of(context).size.width,
      height: height,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      radius: radius,
      child: child ??
          Text(
            text,
            style: textStyle ??
                HelperThemeData.textTheme.buttonText1!
                    .copyWith(color: Colors.white),
          ),
    );
  }
}

class _PrimaryButtonWithIcon extends PrimaryButton {
  _PrimaryButtonWithIcon({
    Key? key,
    required String text,
    TextStyle? textStyle,
    double? width,
    double? height,
    VoidCallback? onPressed,
    Color backgroundColor = HelperColors.orange,
    double? radius,
    required Widget icon,
  }) : super(
          key: key,
          text: text,
          textStyle: textStyle,
          width: width,
          height: height,
          onPressed: onPressed,
          backgroundColor: backgroundColor,
          radius: radius,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: icon,
              ),
              Text(
                text,
                style: textStyle ??
                    HelperThemeData.textTheme.buttonText1!
                        .copyWith(color: Colors.white),
              ),
            ],
          ),
        );
}

class _PrimaryButton extends StatelessWidget {
  final double? height;
  final double? width;
  final VoidCallback? onPressed;
  final Widget? child;
  final Color backgroundColor;
  final double? radius;

  const _PrimaryButton({
    Key? key,
    this.height,
    this.width,
    this.onPressed,
    required this.child,
    this.backgroundColor = HelperColors.orange,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseButton(
      onPressed: onPressed,
      height: height,
      width: width,
      backgroundColor: backgroundColor,
      elevation: 0,
      child: child,
      radius: radius,
    );
  }
}
