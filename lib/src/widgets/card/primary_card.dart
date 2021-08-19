import 'package:flutter/material.dart' hide OutlinedButton;

import '../../../helper_design.dart';

class PrimaryCard extends StatelessWidget {
  final String? title;
  final String? description;
  final String? buttonText;
  final double? buttonHeight;
  final double? buttonWidth;
  final String? illustrationImage;
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
  final BoxBorder? boxBorder;

  const PrimaryCard(
      {Key? key,
      required this.onPressed,
      this.title,
      this.description,
      this.buttonText,
      this.illustrationImage,
      this.buttonHeight,
      this.buttonWidth,
      this.illustrationHeight,
      this.illustrationWidth,
      this.borderColor,
      this.backgroundColor,
      this.radius,
      this.buttonBorderColor,
      this.width,
      this.height,
      this.buttonTextColor,
      this.borderWidth, this.boxBorder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 100,
      decoration: BoxDecoration(
        color: backgroundColor ?? HelperColors.orange10,
        borderRadius: BorderRadius.circular(radius ?? 12.0),
        border:
        boxBorder ?? Border.all(
            width: borderWidth ?? 0.75,
            color: borderColor ?? HelperColors.black10),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Image(
              image: AssetImage(
                  illustrationImage ?? 'assets/images/ilustrasi_beri_tip.webp'),
              fit: BoxFit.fill,
              width: illustrationWidth ?? 142.0,
              height: illustrationHeight ?? 92.0,
            ),
          ),
          Positioned(
            left: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, left: 16.0),
                  child: Text(
                    title ?? 'Beri Tip Buat Helpermu',
                    style: HelperThemeData.textTheme.headline5!.copyWith(
                      fontSize: 16.0,
                      letterSpacing: 0.8 / 100,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    description ?? 'Apresiasi Helper yuk',
                    style: HelperThemeData.textTheme.caption!
                        .copyWith(color: HelperColors.black3),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 12.0, top: 14.0, bottom: 12.0),
                  child: OutlinedButton(
                    backgroundColor: Colors.transparent,
                    borderColor: buttonBorderColor ?? HelperColors.orange,
                    height: buttonHeight ?? 24.0,
                    width: buttonWidth ?? 80.0,
                    onPressed: onPressed,
                    text: buttonText ?? 'Beri Tip',
                    textStyle: HelperThemeData.textTheme.buttonText2!.copyWith(
                        color: buttonTextColor ?? HelperColors.orange),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
