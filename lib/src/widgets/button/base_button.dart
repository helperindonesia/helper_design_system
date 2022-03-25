import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class BaseButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final bool isOutlinedButton;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? radius;
  final Widget? child;
  final double? elevation;
  final double? borderWidth;

  const BaseButton({
    Key? key,
    @required this.onPressed,
    @required this.height,
    @required this.width,
    this.isOutlinedButton = false,
    this.borderColor = HelperColors.orange,
    this.backgroundColor = HelperColors.orange,
    this.radius,
    this.child,
    this.elevation,
    this.borderWidth = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: MaterialButton(
        padding: EdgeInsets.all(0),
        minWidth: 0,
        elevation: elevation,
        onPressed: onPressed,
        disabledColor: HelperColors.black9,
        shape: !isOutlinedButton
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 24))
            : RoundedRectangleBorder(
                side: BorderSide(width: borderWidth!, color: borderColor!),
                borderRadius: BorderRadius.circular(radius ?? 12),
              ),
        color: backgroundColor,
        child: child,
      ),
    );
  }
}
