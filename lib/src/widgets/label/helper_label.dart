import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HelperLabel extends StatelessWidget {
  final String? text;
  final double? radius;
  final Color? backgroundColor;
  final TextStyle? textStyle;

  const HelperLabel(
      {Key? key,
      this.radius,
      required this.backgroundColor,
      required this.text,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 10.0),
          color: backgroundColor),
      child: Text(
        text ?? '',
        style: textStyle ??
            HelperThemeData.textTheme.caption!.copyWith(
              color: HelperColors.white,
            ),
      ),
    );
  }
}
