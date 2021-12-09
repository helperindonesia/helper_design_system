import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class ModalBottomSheet extends StatelessWidget {
  final Color? backgroundColor;
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final IconData? rightIcon;
  final IconData? leftIcon;
  final VoidCallback? onRightButtonPressed;
  final VoidCallback? onLeftButtonPressed;

  const ModalBottomSheet({
    Key? key,
    this.backgroundColor,
    required this.children,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.rightIcon,
    this.leftIcon,
    this.onRightButtonPressed,
    this.onLeftButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: onLeftButtonPressed != null
                    ? MainAxisAlignment.spaceBetween
                    : MainAxisAlignment.end,
                children: [
                  onLeftButtonPressed != null
                      ? BaseButton(
                          onPressed: onLeftButtonPressed,
                          backgroundColor:
                              backgroundColor ?? HelperColors.white,
                          height: 40.0,
                          width: 40.0,
                          child: Icon(
                            leftIcon ?? Icons.arrow_back,
                            size: 24.0,
                            color: HelperColors.black3,
                          ),
                        )
                      : SizedBox(),
                  onRightButtonPressed != null
                      ? BaseButton(
                          onPressed: onRightButtonPressed,
                          backgroundColor:
                              backgroundColor ?? HelperColors.white,
                          height: 40.0,
                          width: 40.0,
                          child: Icon(
                            rightIcon ?? Icons.close_rounded,
                            size: 24.0,
                            color: HelperColors.black3,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: backgroundColor ?? HelperColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
                crossAxisAlignment:
                    crossAxisAlignment ?? CrossAxisAlignment.start,
                children: children,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
