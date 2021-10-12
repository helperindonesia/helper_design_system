import 'package:flutter/material.dart' hide OutlinedButton;

import '../../../helper_design.dart';

class PrimaryCard extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  final String description;
  final TextStyle? descriptionStyle;
  final String buttonText;
  final double? buttonHeight;
  final double? buttonWidth;
  final String illustrationImage;
  final double? illustrationHeight;
  final double? illustrationWidth;
  final VoidCallback onPressed;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? radius;
  final Color? buttonBorderColor;
  final Color? buttonTextColor;
  final double? width;
  final double? height;
  final double? borderWidth;

  const PrimaryCard({
    Key? key,
    required this.onPressed,
    required this.title,
    this.titleStyle,
    required this.description,
    this.descriptionStyle,
    required this.buttonText,
    required this.illustrationImage,
    this.buttonHeight,
    this.buttonWidth,
    this.illustrationHeight,
    this.illustrationWidth,
    this.borderColor,
    this.backgroundColor = HelperColors.orange10,
    this.radius = 12.0,
    this.buttonBorderColor,
    this.width,
    this.height,
    this.buttonTextColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius!),
        side: BorderSide(
          width: borderWidth ?? 0.75,
          color: borderColor ?? HelperColors.black10,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 16.0),
                  child: Text(title,
                      style:
                          titleStyle ?? HelperThemeData.textTheme.buttonText1),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    description,
                    style: descriptionStyle ??
                        HelperThemeData.textTheme.caption!
                            .copyWith(color: HelperColors.black4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 14.0, bottom: 12.0),
                  child: HOutlinedButton(
                    borderColor: buttonBorderColor ?? HelperColors.orange,
                    onPressed: onPressed,
                    text: buttonText,
                  ),
                ),
              ],
            ),
          ),
          Image(
            image: NetworkImage(illustrationImage),
            fit: BoxFit.fill,
            width: illustrationWidth ?? 142.0,
            height: illustrationHeight ?? 92.0,
          ),
        ],
      ),
    );
  }
}
