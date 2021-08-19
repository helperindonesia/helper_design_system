import 'package:flutter/material.dart' hide OutlinedButton;
import 'package:helper_design/helper_design.dart';

class DurationDraggableBottomSheet extends StatelessWidget {
  final Color? durationViewBackgroundColor;
  final String? title;
  final String timer;
  final VoidCallback onPressed;
  final Widget child;
  final double? radius;
  final Color? childBackgroundColor;
  final double? initialChildSize;
  final double? minChildSize;
  final double? maxChildSize;
  final Color? indicatorColor;

  const DurationDraggableBottomSheet({
    Key? key,
    this.durationViewBackgroundColor,
    this.title,
    required this.timer,
    required this.onPressed,
    required this.child,
    this.radius,
    this.childBackgroundColor,
    this.initialChildSize,
    this.minChildSize,
    this.maxChildSize,
    this.indicatorColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      radius: radius,
      initialChildSize: initialChildSize,
      minChildSize: minChildSize,
      maxChildSize: maxChildSize,
      indicatorColor: indicatorColor,
      backgroundColor: durationViewBackgroundColor ?? HelperColors.orange10,
      child: Column(
        children: [
          Container(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      title ?? 'Waktu Pengerjaan',
                      style: HelperThemeData.textTheme.caption!
                          .copyWith(color: HelperColors.black3),
                    ),
                    SizedBox(height: 2.0),
                    Text(
                      timer,
                      style: HelperThemeData.textTheme.headline5!
                          .copyWith(fontSize: 16.0),
                    )
                  ],
                ),
                OutlinedButton.icon(
                  onPressed: onPressed,
                  text: 'Tambah Waktu',
                  width: 139.0,
                  height: 24.0,
                  backgroundColor: Colors.transparent,
                  icon: Icon(
                    Icons.add_circle_rounded,
                    size: 16.0,
                    color: HelperColors.orange,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: childBackgroundColor ?? HelperColors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(radius ?? 16.0),
              ),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
