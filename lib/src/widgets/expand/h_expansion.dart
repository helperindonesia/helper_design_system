import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:helper_design/helper_design.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class HExpansion extends StatefulWidget {
  const HExpansion({
    Key? key,
    this.title,
    this.subtitle,
    this.onExpansionChanged,
    this.children = const <Widget>[],
    this.trailing,
    this.initiallyExpanded = false,
    this.maintainState = false,
    this.expandedCrossAxisAlignment,
    this.expandedAlignment,
    this.childrenPadding,
    this.backgroundColor,
    this.collapsedBackgroundColor,
    this.titleStyle,
    this.subtitleStyle,
    this.onPressed,
  }) : super(key: key);

  final String? title;
  final String? subtitle;
  final ValueChanged<bool>? onExpansionChanged;
  final List<Widget> children;
  final Color? backgroundColor;
  final Color? collapsedBackgroundColor;
  final Widget? trailing;
  final bool initiallyExpanded;
  final bool maintainState;
  final Alignment? expandedAlignment;
  final CrossAxisAlignment? expandedCrossAxisAlignment;
  final EdgeInsetsGeometry? childrenPadding;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final VoidCallback? onPressed;

  @override
  _HExpansionState createState() => _HExpansionState();
}

class _HExpansionState extends State<HExpansion>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeOutTween =
      CurveTween(curve: Curves.easeOut);
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;
  late Animation<Color?> _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));
    _backgroundColor =
        _controller.drive(_backgroundColorTween.chain(_easeOutTween));

    _isExpanded = PageStorage.of(context)?.readState(context) as bool? ??
        widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse().then<void>((void value) {
          if (!mounted) return;
          setState(() {
            // Rebuild without widget.children.
          });
        });
      }
      PageStorage.of(context)?.writeState(context, _isExpanded);
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return CardContainer(
      color: _backgroundColor.value ?? HelperColors.white,
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
      width: MediaQuery.of(context).size.width,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.title ?? 'Title',
                  style: widget.titleStyle ??
                      HelperThemeData.textTheme.buttonText1),
              SizedBox(height: 2),
              Text(
                widget.subtitle ?? 'Subtitle',
                style: widget.subtitleStyle ??
                    HelperThemeData.textTheme.bodyText3!
                        .copyWith(color: HelperColors.black3),
              ),
              Padding(
                padding: EdgeInsets.only(top: _isExpanded ? 16 : 0),
                child: ClipRect(
                  child: Align(
                    alignment: widget.expandedAlignment ?? Alignment.centerLeft,
                    heightFactor: _heightFactor.value,
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: _isExpanded ? 16 : 12, left: 4, right: 4),
          child: DashLine(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HOutlinedButton.icon(
              size: 16,
              textColor: HelperColors.black3,
              borderColor: HelperColors.black5,
              onPressed: widget.onPressed,
              icon: Icon(
                Icons.near_me_rounded,
                size: 16,
                color: HelperColors.black3,
              ),
              text: 'Navigasi',
            ),
            widget.trailing ??
                HOutlinedButton.icon(
                  borderColor: HelperColors.black5,
                  onPressed: _handleTap,
                  icon: RotationTransition(
                    turns: _iconTurns,
                    child: Icon(
                      Icons.expand_more,
                      size: 24,
                      color: HelperColors.black3,
                    ),
                  ),
                ),
          ],
        )
      ],
    );
  }

  @override
  void didChangeDependencies() {
    _backgroundColorTween
      ..begin = widget.collapsedBackgroundColor
      ..end = widget.backgroundColor ?? HelperColors.white;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;
    final bool shouldRemoveChildren = closed && !widget.maintainState;

    final Widget result = Offstage(
      child: TickerMode(
        child: Padding(
          padding: widget.childrenPadding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment:
                widget.expandedCrossAxisAlignment ?? CrossAxisAlignment.center,
            children: widget.children,
          ),
        ),
        enabled: !closed,
      ),
      offstage: closed,
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: shouldRemoveChildren ? null : result,
    );
  }
}
