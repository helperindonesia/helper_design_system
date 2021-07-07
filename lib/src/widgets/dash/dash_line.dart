import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class DashLine extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const DashLine({
    Key? key,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final boxWidth = constraints.constrainWidth();
      final dashWidth = width ?? 4.0;
      final dashHeight = height ?? 0.75;
      final dashCount = (boxWidth / (2 * dashWidth)).floor();
      return Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(dashCount, (_) {
          return SizedBox(
            width: dashWidth,
            height: dashHeight,
            child: DecoratedBox(
              decoration: BoxDecoration(color: color ?? HelperColors.black10),
            ),
          );
        }),
      );
    });
  }
}
