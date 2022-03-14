import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

typedef ExtentListener = Function(double extent);

class DraggableBottomSheet extends StatelessWidget {
  final Widget? child;
  final double radius;
  final Color childBackgroundColor;
  final double initialChildSize;
  final double minChildSize;
  final double maxChildSize;
  final bool withHeader;
  final Widget? headerContent;
  final Color indicatorColor;
  final Color headerBackgroundColor;
  final ExtentListener? extentListener;

  const DraggableBottomSheet({
    Key? key,
    required this.child,
    this.radius = 16,
    this.childBackgroundColor = HelperColors.white,
    this.initialChildSize = 0.2,
    this.minChildSize = 0.1,
    this.maxChildSize = 1.0,
    this.withHeader = false,
    this.headerContent,
    this.indicatorColor = HelperColors.orange8,
    this.headerBackgroundColor = HelperColors.white,
    this.extentListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: (notification) {
        if (extentListener != null) {
          extentListener!(notification.extent);
          return false;
        }
        return false;
      },
      child: DraggableScrollableSheet(
        initialChildSize: initialChildSize,
        minChildSize: minChildSize,
        maxChildSize: maxChildSize,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: headerBackgroundColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radius),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 13.0, bottom: 11.0),
                  height: 2.0,
                  width: 42.0,
                  decoration: BoxDecoration(
                    color: indicatorColor,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                withHeader
                    ? SingleChildScrollView(
                        controller: scrollController,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          color: headerBackgroundColor,
                          child: headerContent,
                        ),
                      )
                    : SizedBox(),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: childBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: child,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
