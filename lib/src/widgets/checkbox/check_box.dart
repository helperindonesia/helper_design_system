import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HCheckBox extends StatelessWidget {
  final String? text;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final double? radius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final double? positionedTop;
  final double? positionedBottom;
  final double? positionedLeft;
  final double? positionedRight;
  final Widget child;
  final EdgeInsetsGeometry? childPadding;

  const HCheckBox(
      {Key? key,
      required this.onChanged,
      required this.value,
      this.text,
      this.radius,
      this.height,
      this.width,
      this.padding,
      this.positionedTop,
      this.positionedBottom,
      this.positionedLeft,
      this.positionedRight,
      required this.child,
      this.childPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius ?? 12),
        border: Border.all(
            width: 0.75,
            color: value ? HelperColors.orange : HelperColors.black10),
      ),
      child: Stack(
        children: [
          Container(
            padding: childPadding,
            child: child,
          ),
          Positioned(
            top: positionedTop ?? 8,
            bottom: positionedBottom,
            left: positionedLeft,
            right: positionedRight ?? 8,
            child: SizedBox(
              height: 24.0,
              width: 24.0,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                shape: CircleBorder(),
                activeColor: HelperColors.orange,
                side: BorderSide(width: 1.0, color: HelperColors.black9),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
