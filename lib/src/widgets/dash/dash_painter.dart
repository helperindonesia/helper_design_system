import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';
import 'dash_border.dart';

typedef PathBuilder = Path Function(Size);

class DashPainter extends CustomPainter {
  final double? strokeWidth;
  final List<double> dashPattern;
  final Color? color;
  final BorderType? borderType;
  final Radius? radius;
  final StrokeCap? strokeCap;
  final PathBuilder? customPath;

  DashPainter({
    this.strokeWidth = 0.75,
    this.dashPattern = const <double>[4, 4],
    this.color = HelperColors.orange,
    this.borderType,
    this.radius = const Radius.circular(12.0),
    this.strokeCap = StrokeCap.round,
    this.customPath,
  }) {
    assert(dashPattern.isNotEmpty, 'Dash Pattern cannot be empty');
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = strokeWidth!
      ..color = color!
      ..strokeCap = strokeCap!
      ..style = PaintingStyle.stroke;

    Path _path;
    if (customPath != null) {
      _path = dashPath(
        customPath!(size),
        dashArray: CircularIntervalList(dashPattern),
      );
    } else {
      _path = _getPath(size);
    }

    canvas.drawPath(_path, paint);
  }

  /// Returns a [Path] based on the the [borderType] parameter
  Path _getPath(Size size) {
    Path path;
    switch (borderType ?? BorderType.RRect) {
      case BorderType.Circle:
        path = _getCirclePath(size);
        break;
      case BorderType.RRect:
        path = _getRRectPath(size, radius!);
        break;
    }

    return dashPath(path, dashArray: CircularIntervalList(dashPattern));
  }

  /// Returns a circular path of [size]
  Path _getCirclePath(Size size) {
    double w = size.width;
    double h = size.height;
    double s = size.shortestSide;

    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            w > s ? (w - s) / 2 : 0,
            h > s ? (h - s / 2) : 0,
            s,
            s,
          ),
          Radius.circular(s / 2),
        ),
      );
  }

  /// Returns a Rounded Rectangular Path with [radius] of [size]
  Path _getRRectPath(Size size, Radius radius) {
    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            0,
            0,
            size.width,
            size.height,
          ),
          radius,
        ),
      );
  }

  @override
  bool shouldRepaint(DashPainter oldDelegate) {
    return oldDelegate.strokeWidth != this.strokeWidth ||
        oldDelegate.color != this.color ||
        oldDelegate.dashPattern != this.dashPattern ||
        oldDelegate.borderType != this.borderType;
  }
}
