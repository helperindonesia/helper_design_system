import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

enum BorderType { Circle, RRect }

class DashBorder extends StatelessWidget {
  final Widget? child;
  final EdgeInsets padding;
  final double strokeWidth;
  final Color borderColor;
  final List<double> dashPattern;
  final BorderType borderType;
  final Radius radius;
  final StrokeCap strokeCap;
  final PathBuilder? customPath;

  DashBorder({
    Key? key,
    this.child,
    this.borderColor = HelperColors.orange,
    this.strokeWidth = 0.75,
    this.borderType = BorderType.RRect,
    this.dashPattern = const <double>[4, 4],
    this.padding = const EdgeInsets.all(2),
    this.radius = const Radius.circular(12.0),
    this.strokeCap = StrokeCap.round,
    this.customPath,
  });

  factory DashBorder.iconWithText({
    Key? key,
    Widget? child,
    EdgeInsets padding,
    double strokeWidth,
    Color borderColor,
    List<double> dashPattern,
    BorderType borderType,
    Radius radius,
    StrokeCap strokeCap,
    PathBuilder? customPath,
    String text,
    TextStyle? textStyle,
    Color childColor,
    IconData iconData,
    double iconSize,
    required VoidCallback? onPressed,
  }) = _DashBorderIconWithText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: DashPainter(
              strokeWidth: strokeWidth,
              radius: radius,
              color: borderColor,
              borderType: borderType,
              dashPattern: dashPattern,
              customPath: customPath,
              strokeCap: strokeCap,
            ),
          ),
        ),
        Padding(
          padding: padding,
          child: child,
        ),
      ],
    );
  }
}

class _DashBorderIconWithText extends DashBorder {
  _DashBorderIconWithText({
    Key? key,
    Widget? child,
    EdgeInsets padding = const EdgeInsets.all(2),
    double strokeWidth = 0.75,
    Color borderColor = HelperColors.orange,
    List<double> dashPattern = const <double>[4, 4],
    BorderType borderType = BorderType.RRect,
    Radius radius = const Radius.circular(12.0),
    StrokeCap strokeCap = StrokeCap.round,
    PathBuilder? customPath,
    String text = 'Tambah',
    TextStyle? textStyle,
    Color childColor = HelperColors.orange,
    IconData iconData = Icons.add_circle_rounded,
    double iconSize = 24.0,
    required VoidCallback? onPressed,
  }) : super(
          key: key,
          padding: padding,
          strokeWidth: strokeWidth,
          borderColor: borderColor,
          dashPattern: dashPattern,
          borderType: borderType,
          radius: radius,
          strokeCap: strokeCap,
          customPath: customPath,
          child: child ??
              InkWell(
                onTap: onPressed,
                child: Container(
                  height: 76.0,
                  width: 76.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        iconData,
                        size: iconSize,
                        color: childColor,
                      ),
                      SizedBox(height: 4.2),
                      Text(
                        text,
                        style: textStyle ??
                            HelperThemeData.textTheme.bodyText1!
                                .copyWith(fontSize: 14.0, color: childColor),
                      )
                    ],
                  ),
                ),
              ),
        );
}
