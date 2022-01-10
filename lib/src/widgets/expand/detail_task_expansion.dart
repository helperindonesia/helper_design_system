import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

const Duration _kExpand = Duration(milliseconds: 200);

class DetailTaskExpansion extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<Widget> children;
  final VoidCallback? navigatePressed;
  final EdgeInsetsGeometry childrenPadding;
  final Color backgroundColor;

  const DetailTaskExpansion(
      {Key? key,
      this.title = 'Title',
      this.subtitle = 'Subtitle',
      this.children = const <Widget>[],
      this.navigatePressed,
      this.childrenPadding = EdgeInsets.zero,
      this.backgroundColor = HelperColors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      color: backgroundColor,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 12, left: 12, right: 12),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: HelperThemeData.textTheme.buttonText1),
              SizedBox(height: 2),
              Text(subtitle,
                  style: HelperThemeData.textTheme.bodyText3!
                      .copyWith(color: HelperColors.black3)),
              Expansion(
                navigatePressed: navigatePressed,
                children: children,
                childrenPadding: childrenPadding,
                backgroundColor: backgroundColor,
              )
            ],
          ),
        )
      ],
    );
  }
}

class Expansion extends StatefulWidget {
  const Expansion({
    Key? key,
    this.children = const <Widget>[],
    this.childrenPadding = EdgeInsets.zero,
    this.backgroundColor = HelperColors.white,
    this.navigatePressed,
  }) : super(key: key);

  final List<Widget> children;
  final Color backgroundColor;
  final EdgeInsetsGeometry childrenPadding;
  final VoidCallback? navigatePressed;

  @override
  _ExpansionState createState() => _ExpansionState();
}

class _ExpansionState extends State<Expansion>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn);
  static final Animatable<double> _halfTween =
      Tween<double>(begin: 0.0, end: 0.5);

  final ColorTween _backgroundColorTween = ColorTween();

  late AnimationController _controller;
  late Animation<double> _iconTurns;
  late Animation<double> _heightFactor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: _kExpand, vsync: this);
    _heightFactor = _controller.drive(_easeInTween);
    _iconTurns = _controller.drive(_halfTween.chain(_easeInTween));

    _isExpanded = PageStorage.of(context)?.readState(context) as bool? ?? false;
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
  }

  Widget _buildChildren(BuildContext context, Widget? child) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: _isExpanded ? 16 : 0),
          child: ClipRect(
            child: Align(
                alignment: Alignment.centerLeft,
                heightFactor: _heightFactor.value,
                child: child),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: _isExpanded ? 16 : 12),
          child: DashLine(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widget.navigatePressed != null
                ? HOutlinedButton.icon(
                    text: 'Navigasi',
                    size: 16,
                    textColor: HelperColors.black3,
                    borderColor: HelperColors.black5,
                    onPressed: widget.navigatePressed,
                    icon: Icon(Icons.near_me_rounded,
                        size: 16, color: HelperColors.black3),
                  )
                : SizedBox(),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: widget.navigatePressed != null ? 0 : 12),
              child: HOutlinedButton.icon(
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
            ),
          ],
        )
      ],
    );
  }

  @override
  void didChangeDependencies() {
    _backgroundColorTween
      ..begin = widget.backgroundColor
      ..end = widget.backgroundColor;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final bool closed = !_isExpanded && _controller.isDismissed;

    final Widget result = Offstage(
      child: TickerMode(
        child: Padding(
          padding: widget.childrenPadding,
          child: Column(children: widget.children),
        ),
        enabled: !closed,
      ),
      offstage: closed,
    );

    return AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: result,
    );
  }
}
