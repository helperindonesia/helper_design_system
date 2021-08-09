import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class LabelNegotiation extends StatelessWidget {
  final String text;
  final double? height;
  final double? width;
  final bool negotiationSuccess;

  const LabelNegotiation(
      {Key? key,
      this.height,
      this.width,
      this.negotiationSuccess = true,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(left: 12.0, right: 13.0, top: 2.0, bottom: 2.0),
      width: width,
      height: height,
      decoration: ShapeDecoration(
        shape: LabelNegotiationShape(
          bottomColor:
              negotiationSuccess ? HelperColors.green : HelperColors.red,
          topColor: negotiationSuccess ? Color(0xFF418C4C) : Color(0xFFB63232),
        ),
      ),
      child: Text(
        text,
        style: HelperThemeData.textTheme.caption!
            .copyWith(color: HelperColors.white),
      ),
    );
  }
}
