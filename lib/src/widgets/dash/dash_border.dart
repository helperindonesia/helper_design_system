import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

enum BorderType { Circle, RRect }

class DashBorder extends StatelessWidget {
  final Widget? child;
  final EdgeInsets? padding;
  final double? strokeWidth;
  final Color? borderColor;
  final List<double>? dashPattern;
  final BorderType? borderType;
  final Radius? radius;
  final StrokeCap? strokeCap;
  final PathBuilder? customPath;

  DashBorder({
    Key? key,
    required this.child,
    this.borderColor,
    this.strokeWidth,
    this.borderType,
    this.dashPattern,
    this.padding,
    this.radius,
    this.strokeCap,
    this.customPath,
  });

  factory DashBorder.iconWithText({
    Key? key,
    Widget? child,
    EdgeInsets? padding,
    double? strokeWidth,
    Color? borderColor,
    List<double>? dashPattern,
    BorderType? borderType,
    Radius? radius,
    StrokeCap? strokeCap,
    PathBuilder? customPath,
    String? text,
    TextStyle? textStyle,
    Color? childColor,
    IconData? iconData,
    double? iconSize,
    required VoidCallback? onPressed,
  }) = _DashBorderIconWithText;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: CustomPaint(
            painter: DashPainter(
              strokeWidth: strokeWidth ?? 0.75,
              radius: radius ?? const Radius.circular(12.0),
              color: borderColor ?? HelperColors.orange,
              borderType: borderType ?? BorderType.RRect,
              dashPattern: dashPattern ?? const <double>[4, 4],
              customPath: customPath,
              strokeCap: strokeCap ?? StrokeCap.round,
            ),
          ),
        ),
        Padding(
          padding: padding ?? const EdgeInsets.all(2),
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
    EdgeInsets? padding,
    double? strokeWidth,
    Color? borderColor,
    List<double>? dashPattern,
    BorderType? borderType,
    Radius? radius,
    StrokeCap? strokeCap,
    PathBuilder? customPath,
    String? text,
    TextStyle? textStyle,
    Color? childColor,
    IconData? iconData,
    double? iconSize,
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
                        iconData ?? Icons.add_circle_rounded,
                        size: iconSize ?? 24.0,
                        color: childColor ?? HelperColors.orange,
                      ),
                      SizedBox(height: 4.2),
                      Text(
                        text ?? 'Tambah',
                        style: textStyle ??
                            HelperThemeData.textTheme.bodyText1!.copyWith(
                                fontSize: 14.0,
                                color: childColor ?? HelperColors.orange),
                      )
                    ],
                  ),
                ),
              ),
        );
}
