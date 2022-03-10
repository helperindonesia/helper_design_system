import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class ModalBottomSheet extends StatelessWidget {
  final Color backgroundColor;
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final IconData rightIcon;
  final IconData leftIcon;
  final VoidCallback? onRightButtonPressed;
  final VoidCallback? onLeftButtonPressed;
  final EdgeInsetsGeometry? contentPadding;

  const ModalBottomSheet({
    Key? key,
    this.backgroundColor = HelperColors.white,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.rightIcon = Icons.close_rounded,
    this.leftIcon = Icons.arrow_back,
    this.onRightButtonPressed,
    this.onLeftButtonPressed,
    this.contentPadding = const EdgeInsets.all(16),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 1,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: onLeftButtonPressed != null
                ? MainAxisAlignment.spaceBetween
                : MainAxisAlignment.end,
            children: [
              if (onLeftButtonPressed != null)
                BaseButton(
                  onPressed: onLeftButtonPressed,
                  backgroundColor: backgroundColor,
                  height: 40.0,
                  width: 40.0,
                  child: Icon(
                    leftIcon,
                    size: 24.0,
                    color: HelperColors.black3,
                  ),
                ),
              if (onRightButtonPressed != null)
                BaseButton(
                  onPressed: onRightButtonPressed,
                  backgroundColor: backgroundColor,
                  height: 40.0,
                  width: 40.0,
                  child: Icon(
                    rightIcon,
                    size: 24.0,
                    color: HelperColors.black3,
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: contentPadding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(16.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            children: children,
          ),
        ),
      ],
    );
  }
}
