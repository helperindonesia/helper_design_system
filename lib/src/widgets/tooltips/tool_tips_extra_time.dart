import 'package:flutter/material.dart' hide OutlinedButton;
import 'package:helper_design/helper_design.dart';

class ToolTipsExtraTime extends StatelessWidget {
  final String? text;
  final TextStyle? textStyle;
  final VoidCallback? onPressed;

  const ToolTipsExtraTime(
      {Key? key, required this.text, this.textStyle, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: ToolTipsShapeBorder(),
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
            OutlinedButton(
                height: 24.0,
                borderColor: HelperColors.white,
                width: 103.0,
                backgroundColor: Colors.transparent,
                text: 'Ya, Tambah',
                textStyle: HelperThemeData.textTheme.buttonText2!
                    .copyWith(color: HelperColors.white),
                onPressed: onPressed)
          ],
        ),
      ),
    );
  }
}
