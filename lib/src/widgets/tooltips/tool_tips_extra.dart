import 'package:flutter/material.dart' hide OutlinedButton;
import 'package:helper_design/helper_design.dart';

class ToolTipsExtra extends StatelessWidget {
  final String text;
  final String buttonText;
  final TextStyle? textStyle;
  final VoidCallback onPressed;
  final double padding;
  final ToolTipTickPosition toolTipTickPosition;

  const ToolTipsExtra(
      {Key? key,
      required this.text,
      this.textStyle,
      required this.onPressed,
      this.padding = 49.0,
      this.buttonText = 'Ok, Mengerti',
      this.toolTipTickPosition = ToolTipTickPosition.RIGHT})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: ShapeDecoration(
        shape: ToolTipsShapeBorder(
            toolTipTickPosition: toolTipTickPosition, padding: padding),
        color: HelperColors.black2,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: textStyle ??
                  HelperThemeData.textTheme.bodyText3!
                      .copyWith(color: HelperColors.white),
            ),
            SizedBox(height: 12.0),
            HOutlinedButton(
                textColor: HelperColors.white,
                borderColor: HelperColors.white,
                text: buttonText,
                onPressed: onPressed)
          ],
        ),
      ),
    );
  }
}
