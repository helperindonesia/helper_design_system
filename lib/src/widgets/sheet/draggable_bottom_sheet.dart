import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class DraggableBottomSheet extends StatelessWidget {
  final Widget? child;
  final double? radius;
  final Color? childBackgroundColor;
  final double? initialChildSize;
  final double? minChildSize;
  final double? maxChildSize;
  final bool withHeader;
  final Widget? headerContent;
  final Color? indicatorColor;
  final Color? headerBackgroundColor;

  const DraggableBottomSheet(
      {Key? key,
      required this.child,
      this.radius,
      this.childBackgroundColor,
      this.initialChildSize,
      this.minChildSize,
      this.maxChildSize,
      this.withHeader = false,
      this.headerContent,
      this.indicatorColor,
      this.headerBackgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: initialChildSize ?? 0.2,
      minChildSize: minChildSize ?? 0.1,
      maxChildSize: maxChildSize ?? 1.0,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: headerBackgroundColor ?? HelperColors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(radius ?? 16.0),
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
                    color: indicatorColor ?? HelperColors.orange8,
                    borderRadius: BorderRadius.circular(50.0)),
              ),
              withHeader
                  ? SingleChildScrollView(
                      controller: scrollController,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: headerBackgroundColor ?? HelperColors.white,
                        child: headerContent,
                      ),
                    )
                  : SizedBox(),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: childBackgroundColor ?? HelperColors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16))),
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
    );
  }
}
