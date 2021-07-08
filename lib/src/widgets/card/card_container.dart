import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class CardContainer extends StatelessWidget {
  final List<Widget>? children;
  final double? elevation;
  final double? width, height;
  final CardType cardType;
  final Color? color;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BoxBorder? border;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  const CardContainer({
    Key? key,
    this.children,
    this.elevation,
    this.width,
    this.height,
    this.cardType = CardType.vertical,
    this.color,
    this.radius,
    this.padding,
    this.margin,
    this.border,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
  }) : super(key: key);

  factory CardContainer.horizontal({
    List<Widget>? children,
    double? elevation = 0,
    double? width,
    double? height,
    Color? color,
    double? radius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    BoxBorder? border,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisAlignment? mainAxisAlignment,
  }) =>
      CardContainer(
        children: children,
        radius: radius ?? 12.0,
        elevation: elevation,
        width: width,
        height: height,
        cardType: CardType.horizontal,
        color: color ?? HelperColors.white,
        padding: padding,
        margin: margin,
        border: border,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: Material(
        borderRadius: BorderRadius.circular(radius ?? 12.0),
        elevation: elevation ?? 0,
        color: color ?? HelperColors.white,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: border ?? Border.all(width: 0.75, color: HelperColors.black10),
            borderRadius: BorderRadius.circular(radius ?? 12.0),
          ),
          child: cardType == CardType.vertical
              ? Column(
                  crossAxisAlignment:
                      crossAxisAlignment ?? CrossAxisAlignment.start,
                  mainAxisAlignment:
                      mainAxisAlignment ?? MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: children as List<Widget>,
                )
              : Row(
                  children: children as List<Widget>,
                  mainAxisAlignment:
                      mainAxisAlignment ?? MainAxisAlignment.center,
                ),
        ),
      ),
    );
  }
}

enum CardType { horizontal, vertical }
