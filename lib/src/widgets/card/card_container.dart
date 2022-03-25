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
  final Color? borderColor;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisAlignment? mainAxisAlignment;

  const CardContainer({
    Key? key,
    this.children,
    this.elevation = 0,
    this.width,
    this.height,
    this.cardType = CardType.vertical,
    this.color = HelperColors.white,
    this.radius = 12.0,
    this.padding,
    this.margin,
    this.border,
    this.crossAxisAlignment,
    this.mainAxisAlignment,
    this.borderColor = HelperColors.black10,
  }) : super(key: key);

  factory CardContainer.horizontal({
    List<Widget>? children,
    double? elevation = 0,
    double? width,
    double? height,
    Color? color = HelperColors.white,
    double? radius = 12.0,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry margin = EdgeInsets.zero,
    BoxBorder? border,
    Color? borderColor,
    CrossAxisAlignment? crossAxisAlignment,
    MainAxisAlignment? mainAxisAlignment,
  }) =>
      CardContainer(
        children: children,
        radius: radius,
        elevation: elevation,
        width: width,
        height: height,
        cardType: CardType.horizontal,
        color: color,
        padding: padding,
        margin: margin,
        border: border,
        borderColor: borderColor,
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
        borderRadius: BorderRadius.circular(radius!),
        elevation: elevation!,
        color: color,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            border: border ?? Border.all(width: 0.75, color: borderColor!),
            borderRadius: BorderRadius.circular(radius!),
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
                  crossAxisAlignment:
                      crossAxisAlignment ?? CrossAxisAlignment.center,
                ),
        ),
      ),
    );
  }
}

enum CardType { horizontal, vertical }
