import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class DashLine extends StatelessWidget {
  final double? dashHeight;
  final double? dashWidth;
  final Color? color;
  final double? height;
  final double? width;

  const DashLine({
    Key? key,
    this.dashHeight = 0.75,
    this.dashWidth = 4.0,
    this.color = HelperColors.black10,
    this.height = 0.75,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashedWidth = dashWidth;
        final dashedHeight = dashHeight;
        final dashCount = (boxWidth / (2 * dashedWidth!)).floor();
        return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashedWidth,
              height: dashedHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      }),
    );
  }
}
