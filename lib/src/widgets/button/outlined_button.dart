import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HOutlinedButton extends OutlinedButton {
  HOutlinedButton({
    Key? key,
    this.text,
    this.borderColor,
    required this.onPressed,
    Widget? child,
    this.radius,
    this.textColor,
    ButtonStyle? buttonStyle,
  }) : super(
          key: key,
          child: child ?? Text(text ?? ''),
          onPressed: onPressed,
          style: buttonStyle,
        );

  final String? text;
  final Color? borderColor;
  final VoidCallback? onPressed;
  final double? radius;
  final Color? textColor;

  factory HOutlinedButton.icon({
    Key? key,
    String? text,
    Color? borderColor,
    required VoidCallback onPressed,
    required Widget icon,
    double? radius,
    double? borderWidth,
    Color? textColor,
    double? size = 24,
  }) =>
      _HOutlinedButtonWithIcon(
        onPressed: onPressed,
        icon: icon,
        borderColor: borderColor,
        radius: radius,
        text: text,
        textColor: textColor,
        size: size,
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

    final OutlinedBorder? shape =
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

    final MaterialStateProperty<BorderSide?>? resolvedBorderColor =
        _HOutlinedButtonResolvedBorderColor(
      borderColor ?? colorScheme.primary,
      colorScheme.onSurface,
    );

    ButtonStyle style = ButtonStyle(side: resolvedBorderColor);

    style = style.merge(OutlinedButton.styleFrom(
      primary: textColor ?? colorScheme.primary,
      onSurface: colorScheme.onSurface,
      backgroundColor: Colors.transparent,
      shadowColor: theme.shadowColor,
      elevation: 0,
      textStyle: theme.textTheme.button,
      padding: scaledPadding,
      minimumSize: Size(24, 24),
      shape: shape,
      enabledMouseCursor: SystemMouseCursors.click,
      disabledMouseCursor: SystemMouseCursors.forbidden,
      visualDensity: theme.visualDensity,
      tapTargetSize: theme.materialTapTargetSize,
      animationDuration: kThemeChangeDuration,
      enableFeedback: true,
      alignment: Alignment.center,
      splashFactory: InkRipple.splashFactory,
    ));

    return style;
  }
}

class _HOutlinedButtonWithIcon extends HOutlinedButton {
  _HOutlinedButtonWithIcon({
    Key? key,
    String? text,
    required VoidCallback? onPressed,
    required Widget icon,
    Color? borderColor,
    double? radius,
    Color? textColor,
    double? size = 24,
  }) : super(
          key: key,
          onPressed: onPressed,
          borderColor: borderColor,
          textColor: textColor,
          buttonStyle: text != null
              ? OutlinedButton.styleFrom(
                  padding: EdgeInsets.only(
                      left: 6, right: 10, top: 2.5, bottom: 2.5),
                )
              : OutlinedButton.styleFrom(
                  fixedSize: Size(size!, size),
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
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

@immutable
class _HOutlinedButtonResolvedBorderColor
    extends MaterialStateProperty<BorderSide?> with Diagnosticable {
  _HOutlinedButtonResolvedBorderColor(this.primary, this.onSurface);

  final Color? primary;
  final Color? onSurface;

  @override
  BorderSide? resolve(Set<MaterialState> states) {
    if (states.contains(MaterialState.disabled))
      return BorderSide(width: 1, color: onSurface!.withOpacity(0.38));

    return BorderSide(width: 1, color: primary!);
  }
}
