import 'package:flutter/material.dart';

enum TypeMessage { Sender, Receiver }

class ChatBubbleShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double radius;
  final double padding;
  final TypeMessage typeMessage;

  ChatBubbleShapeBorder({
    this.radius = 12.0,
    this.arrowWidth = 8.0,
    this.arrowHeight = 16.0,
    this.padding = 12.0,
    this.typeMessage = TypeMessage.Sender
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) =>
      null ?? Path();

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    if (typeMessage != TypeMessage.Sender) {
      rect = Rect.fromPoints(rect.topLeft, rect.bottomRight);
      return Path()
        ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
        ..moveTo(rect.topLeft.dx, rect.topLeft.dy + padding)
        ..relativeQuadraticBezierTo(-arrowHeight, arrowWidth, 0, arrowHeight);
    } else {
      rect = Rect.fromPoints(
          rect.topLeft, rect.bottomRight + Offset(0, 0));
      return Path()
        ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
        ..moveTo(rect.topRight.dx, rect.topRight.dy + padding)
        ..relativeQuadraticBezierTo(arrowHeight, arrowWidth, 0, arrowHeight);
    }
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}
