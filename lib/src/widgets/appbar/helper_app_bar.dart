import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HelperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final TextStyle? textStyle;
  final Widget? leading;
  final double? leadingSize;
  final VoidCallback? onPressed;
  final List<Widget>? actions;
  final double? elevation;
  final Color? backgroundColor;

  const HelperAppBar({
    Key? key,
    this.title,
    this.textStyle,
    this.leading,
    this.leadingSize,
    this.onPressed,
    this.actions,
    this.elevation,
    this.backgroundColor,
  }) : super(key: key);

  factory HelperAppBar.helpIcon({
    String? title,
    TextStyle? textStyle,
    IconData? leadingIcon,
    double? leadingSize,
    VoidCallback? onPressed,
    VoidCallback? onHelpPressed,
    List<Widget>? actions,
    double? elevation,
    Color? backgroundColor,
  }) = _HelperAppBarWithHelpIcon;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: HelperColors.black,
      titleSpacing: 0.0,
      leading: leading,
      title: title,
      centerTitle: false,
      actions: actions,
      elevation: elevation ?? 4 / 100,
      backgroundColor: backgroundColor ?? HelperColors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _HelperAppBarWithHelpIcon extends HelperAppBar {
  _HelperAppBarWithHelpIcon(
      {Key? key,
      String? title,
      TextStyle? textStyle,
      IconData? leadingIcon,
      double? leadingSize,
      VoidCallback? onPressed,
      VoidCallback? onHelpPressed,
      List<Widget>? actions,
      double? elevation,
      Color? backgroundColor})
      : super(
            key: key,
            leading: IconButton(
              onPressed: onPressed,
              icon: Icon(
                leadingIcon ?? Icons.arrow_back,
                color: HelperColors.black3,
              ),
              iconSize: leadingSize ?? 24.0,
            ),
            title: Text(
              title ?? '',
              style: textStyle ??
                  HelperThemeData.textTheme.headline4!
                      .copyWith(color: HelperColors.black),
            ),
            actions: actions ??
                <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(right: 16.0),
                    onPressed: onHelpPressed,
                    icon: Icon(
                      Icons.help,
                      color: HelperColors.black3,
                    ),
                    iconSize: 24.0,
                  )
                ],
            elevation: elevation,
            backgroundColor: backgroundColor);
}
