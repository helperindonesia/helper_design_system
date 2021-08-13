import 'package:flutter/material.dart';

class LabelNegotiationShape extends ShapeBorder {
  final double radius;
  final double size;
  final Color topColor;
  final Color bottomColor;

  LabelNegotiationShape({
    this.radius = 10,
    this.size = 8,
    required this.topColor,
    required this.bottomColor,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      null ?? Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return Path();
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    Paint topPaint = new Paint()..color = topColor;
    Paint bottomPaint = new Paint()..color = bottomColor;
    rect = Rect.fromPoints(rect.topLeft, rect.bottomRight);

    Path topPath = Path();
    topPath.moveTo(rect.topRight.dx, rect.topRight.dy);
    topPath.relativeQuadraticBezierTo(-size, size * 2, -size, -size);

    Path bottomPath = Path();
    bottomPath.addRRect(RRect.fromRectAndCorners(rect,
        topLeft: Radius.circular(radius),
        bottomLeft: Radius.circular(radius),
        bottomRight: Radius.circular(radius)));

    canvas.drawPath(topPath, topPaint);
    canvas.drawPath(bottomPath, bottomPaint);
  }

  @override
  ShapeBorder scale(double t) => this;
}
