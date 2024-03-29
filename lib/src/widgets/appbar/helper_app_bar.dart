import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HelperAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final TextStyle? textStyle;
  final Widget? leading;
  final double? leadingSize;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final double? elevation;
  final Color? backgroundColor;
  final TextStyle? toolbarTextStyle;

  const HelperAppBar({
    Key? key,
    this.title,
    this.textStyle,
    this.leading,
    this.leadingSize,
    this.onBackPressed,
    this.actions,
    this.elevation = 4 / 100,
    this.backgroundColor = HelperColors.white,
    this.toolbarTextStyle,
  }) : super(key: key);

  factory HelperAppBar.helpIcon({
    String? title,
    TextStyle? textStyle,
    IconData? leadingIcon,
    double leadingSize,
    VoidCallback? onBackPressed,
    VoidCallback? onHelpPressed,
    List<Widget>? actions,
    double? elevation,
    Color? backgroundColor,
  }) = _HelperAppBarWithHelpIcon;

  factory HelperAppBar.image({
    Key? key,
    String? name,
    required String mediaUrl,
    TextStyle? textStyle,
    IconData? leadingIcon,
    double leadingSize,
    VoidCallback? onBackPressed,
    VoidCallback? onImagePressed,
    List<Widget>? actions,
    double? elevation,
    Color? backgroundColor,
  }) = _HelperAppBarWithImage;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      shadowColor: HelperColors.black,
      titleSpacing: 0.0,
      leading: leading != null
          ? InkWell(
              onTap: onBackPressed ?? () => Navigator.pop(context),
              child: leading,
            )
          : null,
      title: title,
      centerTitle: false,
      actions: actions,
      elevation: elevation,
      backgroundColor: backgroundColor,
      titleTextStyle: toolbarTextStyle ??
          Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(color: HelperColors.black2),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _HelperAppBarWithHelpIcon extends HelperAppBar {
  _HelperAppBarWithHelpIcon({
    Key? key,
    String? title = '',
    TextStyle? textStyle,
    IconData? leadingIcon = Icons.arrow_back,
    double leadingSize = 24.0,
    VoidCallback? onBackPressed,
    VoidCallback? onHelpPressed,
    List<Widget>? actions,
    double? elevation,
    Color? backgroundColor,
  }) : super(
            key: key,
            leading: IconButton(
              onPressed: onBackPressed,
              icon: Icon(
                leadingIcon,
                color: HelperColors.black3,
              ),
              iconSize: leadingSize,
            ),
            title: Text(
              title!,
              style: textStyle ??
                  HelperThemeData.textTheme.headline4!.copyWith(
                      color: HelperColors.black, fontWeight: FontWeight.w800),
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

class _HelperAppBarWithImage extends HelperAppBar {
  _HelperAppBarWithImage({
    Key? key,
    String? name = '',
    required String mediaUrl,
    TextStyle? textStyle,
    IconData? leadingIcon = Icons.arrow_back_rounded,
    double leadingSize = 24.0,
    VoidCallback? onBackPressed,
    VoidCallback? onImagePressed,
    List<Widget>? actions,
    double? elevation,
    Color? backgroundColor,
    bool leading = false,
  }) : super(
          key: key,
          leading: leading
              ? IconButton(
                  onPressed: onBackPressed,
                  icon: Icon(
                    leadingIcon,
                    color: HelperColors.black3,
                  ),
                  iconSize: leadingSize,
                )
              : null,
          title: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MediaThumbnail(
                onPressed: onImagePressed,
                margin: leading ? null : EdgeInsets.only(left: 16.0),
                height: 40.0,
                width: 40.0,
                borderRadius: BorderRadius.circular(24.0),
                mediaUrl: mediaUrl,
              ),
              SizedBox(width: 12.0),
              Text(
                name!,
                style: textStyle ??
                    HelperThemeData.textTheme.headline4!.copyWith(
                      color: HelperColors.black,
                      fontWeight: FontWeight.w800,
                    ),
              ),
            ],
          ),
          actions: actions ?? <Widget>[],
          elevation: elevation,
          backgroundColor: backgroundColor,
        );
}
