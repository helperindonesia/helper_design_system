import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class ModalBottomSheet extends StatelessWidget {
  final Color? backgroundColor;
  final List<Widget> children;
  final MainAxisAlignment? mainAxisAlignment;
  final IconData? firstIcon;
  final IconData? secondIcon;
  final VoidCallback? firstButtonPressed;
  final VoidCallback? secondButtonPressed;
  final bool multipleButtonOnTop;

  const ModalBottomSheet({
    Key? key,
    this.backgroundColor,
    required this.children,
    this.mainAxisAlignment,
    this.firstIcon,
    this.secondIcon,
    this.firstButtonPressed,
    this.secondButtonPressed,
    this.multipleButtonOnTop = false,
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
                mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
                children: [
                  BaseButton(
                    onPressed:
                        firstButtonPressed ?? () => Navigator.pop(context),
                    backgroundColor: backgroundColor ?? HelperColors.white,
                    height: 40.0,
                    width: 40.0,
                    child: Icon(
                      firstIcon ?? Icons.close_rounded,
                      size: 24.0,
                      color: HelperColors.black3,
                    ),
                  ),
                  multipleButtonOnTop
                      ? BaseButton(
                          onPressed: secondButtonPressed ?? () => () {},
                          backgroundColor:
                              backgroundColor ?? HelperColors.white,
                          height: 40.0,
                          width: 40.0,
                          child: Icon(
                            secondIcon ?? Icons.my_location_rounded,
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
                children: children,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
