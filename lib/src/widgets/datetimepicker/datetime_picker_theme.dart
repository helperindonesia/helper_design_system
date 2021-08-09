import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class DatePickerTheme {
  final TextStyle? itemStyle;
  final Color backgroundColor;
  final double containerHeight;
  final double itemHeight;

  final double borderWidth;
  final double borderRadius;
  final Color borderColor;

  final double innerBorderWidth;
  final double innerBorderRadius;
  final Color innerBorderColor;

  final EdgeInsetsGeometry margin;

  const DatePickerTheme({
    this.itemStyle,
    this.backgroundColor = HelperColors.white,
    this.containerHeight = 214,
    this.itemHeight = 50,
    this.borderWidth = 0.75,
    this.borderRadius = 12.0,
    this.borderColor = HelperColors.black10,
    this.margin = const EdgeInsets.all(16.0),
    this.innerBorderWidth = 1.0,
    this.innerBorderRadius = 12.0,
    this.innerBorderColor = HelperColors.orange,
  });
}
