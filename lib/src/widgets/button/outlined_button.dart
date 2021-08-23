import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

enum OutlineType { rounded, circle }

class HOutlinedButton extends OutlinedButton {
  final String? text;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final double? radius;
  final Color? textColor;
  final OutlineType? outlineType;

  HOutlinedButton({
    Key? key,
    this.text,
    this.borderColor,
    required this.onPressed,
    Widget? child,
    this.radius,
    this.textColor,
    this.outlineType = OutlineType.rounded,
    ButtonStyle? buttonStyle,
  }) : super(
          key: key,
          child: child ?? Text(text ?? ''),
          onPressed: onPressed,
          style: buttonStyle,
        );

  factory HOutlinedButton.icon({
    Key? key,
    String? text,
    Color? borderColor,
    required VoidCallback onPressed,
    required Widget icon,
    double? radius,
    double? borderWidth,
    Color? textColor,
    OutlineType? outlineType,
  }) =>
      _HOutlinedButtonWithIcon(
        onPressed: onPressed,
        icon: icon,
        borderColor: borderColor,
        outlineType: outlineType,
        radius: radius,
        text: text,
        textColor: textColor,
      );

  @override
  ButtonStyle defaultStyleOf(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    final EdgeInsetsGeometry scaledPadding = ButtonStyleButton.scaledPadding(
      const EdgeInsets.symmetric(horizontal: 16),
      const EdgeInsets.symmetric(horizontal: 8),
      const EdgeInsets.symmetric(horizontal: 4),
      MediaQuery.maybeOf(context)?.textScaleFactor ?? 1,
    );

    OutlinedBorder? shape;

    switch (outlineType) {
      case OutlineType.rounded:
        shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
        break;
      case OutlineType.circle:
        shape = CircleBorder();
        break;
      default:
        shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
    }

    return OutlinedButton.styleFrom(
      primary: textColor ?? colorScheme.primary,
      onSurface: colorScheme.onSurface,
      backgroundColor: Colors.transparent,
      shadowColor: theme.shadowColor,
      elevation: 0,
      textStyle: theme.textTheme.button,
      padding: scaledPadding,
      // fixedSize: Size(20, 20),
      minimumSize: const Size(48, 24),
      side: BorderSide(
        color: borderColor ?? HelperColors.orange,
        width: 1,
      ),
      shape: shape,
      enabledMouseCursor: SystemMouseCursors.click,
      disabledMouseCursor: SystemMouseCursors.forbidden,
      visualDensity: theme.visualDensity,
      tapTargetSize: theme.materialTapTargetSize,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
      alignment: Alignment.center,
      splashFactory: InkRipple.splashFactory,
    );
  }
}

class _HOutlinedButtonWithIcon extends HOutlinedButton {
  _HOutlinedButtonWithIcon({
    Key? key,
    String? text,
    required VoidCallback? onPressed,
    required Widget icon,
    OutlineType? outlineType,
    Color? borderColor,
    double? radius,
    Color? textColor,
  }) : super(
          key: key,
          onPressed: onPressed,
          outlineType: outlineType,
          borderColor: borderColor,
          textColor: textColor,
          child: text != null
              ? _OutlinedButtonWithIconChild(
                  label: Text(text),
                  icon: icon,
                )
              : icon,
        );
}

class _OutlinedButtonWithIconChild extends StatelessWidget {
  const _OutlinedButtonWithIconChild({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  final Widget label;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final double scale = MediaQuery.maybeOf(context)?.textScaleFactor ?? 1;
    final double gap =
        scale <= 1 ? 8 : lerpDouble(8, 4, math.min(scale - 1, 1))!;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[icon, SizedBox(width: gap), label],
    );
  }
}
