import 'package:flutter/material.dart';

enum ToolTipTickPosition { LEFT, RIGHT }

class ToolTipsShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double arrowArc;
  final double radius;
  final double padding;
  final ToolTipTickPosition toolTipTickPosition;

  ToolTipsShapeBorder(
      {this.radius = 0,
      this.arrowWidth = 16.0,
      this.arrowHeight = 8.0,
      this.arrowArc = 0.5,
      this.padding = 49.0,
      this.toolTipTickPosition = ToolTipTickPosition.RIGHT})
      : assert(arrowArc <= 1.0 && arrowArc >= 0.0);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      null ?? Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    rect = Rect.fromPoints(
        rect.topLeft, rect.bottomRight - Offset(0, arrowHeight));
    double x = arrowWidth, y = arrowHeight, r = 1 - arrowArc;
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(
          toolTipTickPosition == ToolTipTickPosition.RIGHT
              ? rect.topRight.dx - padding
              : rect.topLeft.dx + padding,
          toolTipTickPosition == ToolTipTickPosition.RIGHT
              ? rect.topRight.dy
              : rect.topLeft.dy)
      ..relativeLineTo(-x / 2 * r, -y * r)
      ..relativeQuadraticBezierTo(
          -x / 2 * (1 - r), -y * (1 - r), -x * (1 - r), 0)
      ..relativeLineTo(-x / 2 * r, y * r);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
