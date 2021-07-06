import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HelperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final TextStyle? textStyle;

  final IconData? leading;
  final double? leadingSize;

  final VoidCallback? onLeadingPressed;
  final VoidCallback? onHelpPressed;
  final List<Widget>? actions;
  final double? elevation;
  final Color? backgroundColor;
  final bool isHelp;

  const HelperAppBar({
    Key? key,
    this.title,
    this.textStyle,
    this.leading,
    this.leadingSize,
    this.onLeadingPressed,
    this.onHelpPressed,
    this.actions,
    this.elevation,
    this.backgroundColor,
    this.isHelp = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0.0,
      leading: InkWell(
        onTap: onLeadingPressed,
        child: Icon(
          leading ?? Icons.arrow_back,
          color: HelperColors.black3,
          size: leadingSize ?? 24.0,
        ),
      ),
      title: Text(
        title ?? '',
        style: textStyle ??
            HelperThemeData.textTheme.headline4!
                .copyWith(color: HelperColors.black),
      ),
      centerTitle: false,
      actions: isHelp
          ? <Widget>[
              InkWell(
                onTap: onHelpPressed,
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Icon(
                    Icons.help,
                    color: HelperColors.black3,
                    size: 24.0,
                  ),
                ),
              )
            ]
          : actions,
      elevation: elevation ?? 4/100,
      backgroundColor: backgroundColor ?? HelperColors.white,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
