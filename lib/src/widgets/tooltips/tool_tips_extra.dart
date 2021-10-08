import 'package:flutter/material.dart' hide OutlinedButton;
import 'package:helper_design/helper_design.dart';

class ToolTipsExtra extends StatelessWidget {
  final String? text;
  final String? buttonText;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;
  final double? padding;

  const ToolTipsExtra(
      {Key? key,
      required this.text,
      this.textStyle,
      required this.onPressed,
      this.padding,
      this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        shape: ToolTipsShapeBorder(padding: padding ?? 49.0),
        color: HelperColors.black2,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text ?? "",
              style: textStyle ??
                  HelperThemeData.textTheme.bodyText3!
                      .copyWith(color: HelperColors.white),
            ),
            SizedBox(height: 12.0),
            HOutlinedButton(
                textColor: HelperColors.white,
                borderColor: HelperColors.white,
                text: buttonText ??'Ok, Mengerti',
                onPressed: onPressed)
          ],
        ),
      ),
    );
  }
}
