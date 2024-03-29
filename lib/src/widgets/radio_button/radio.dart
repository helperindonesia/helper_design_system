import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HRadio<T> extends StatefulWidget {
  const HRadio({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.title,
    this.titleStyle,
    this.subtitle,
    this.subtitleStyle,
    this.size = 24,
    this.controlAffinity = ListTileControlAffinity.platform,
    this.icon,
    this.withBorder = false,
  }) : super(key: key);
  final T value;

  final T? groupValue;

  final ValueChanged<T?> onChanged;

  final double size;

  final ListTileControlAffinity controlAffinity;

  final Widget? icon;

  final bool withBorder;

  final String? title;

  final TextStyle? titleStyle;

  final String? subtitle;

  final TextStyle? subtitleStyle;

  bool get _selected => value == groupValue;

  @override
  _HRadioState createState() => _HRadioState<T>();
}

class _HRadioState<T> extends State<HRadio<T>> with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation> _animations;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _animations = [
      CurvedAnimation(parent: _controller, curve: Curves.ease),
      ColorTween(
        begin: HelperColors.black10,
        end: HelperColors.orange,
      ).animate(_controller),
      ColorTween(
        begin: HelperColors.black10,
        end: HelperColors.orange9,
      ).animate(_controller),
      ColorTween(
        begin: HelperColors.black3,
        end: HelperColors.orange,
      ).animate(_controller),
    ];

    _animations.forEach((anim) => anim.addListener(() => setState(() {})));

    if (widget._selected)
      _controller.value = 1.0;
    else
      _controller.value = 0.0;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  void didUpdateWidget(covariant HRadio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if ((widget._selected &&
            (_controller.status == AnimationStatus.dismissed ||
                _controller.status == AnimationStatus.reverse)) ||
        (!widget._selected &&
            (_controller.status == AnimationStatus.completed ||
                _controller.status == AnimationStatus.forward))) {
      _updateState();
    }
  }

  void _updateState() {
    setState(() {
      if (widget._selected && _controller.status != AnimationStatus.completed) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  void _handleChanged() {
    widget.onChanged(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final int alpha = (_animations[0].value * 255).toInt();

    final Widget control = AnimatedContainer(
      duration: _controller.duration!,
      curve: Curves.ease,
      height: widget.size,
      width: widget.size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: HelperColors.orange.withAlpha(alpha),
        border: Border.all(
          width: 1.0,
          color: _animations[1].value,
        ),
      ),
      child: widget._selected
          ? Icon(
              Icons.check_rounded,
              color: HelperColors.white,
              size: widget.size - 4,
            )
          : SizedBox.shrink(),
    );

    final Widget? icon = widget.icon != null
        ? CircleAvatar(
            backgroundColor: _animations[2].value,
            radius: 16,
            child: widget.icon
          )
        : null;

    Widget? leading, trailing;

    switch (widget.controlAffinity) {
      case ListTileControlAffinity.leading:
      case ListTileControlAffinity.platform:
        leading = control;
        trailing = icon;
        break;
      case ListTileControlAffinity.trailing:
        leading = icon;
        trailing = control;
        break;
    }

    final Widget tile = ListTile(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      leading: leading,
      trailing: trailing,
      title: Text(widget.title ?? '', style: widget.titleStyle),
      subtitle: widget.subtitle != null ? Text(widget.subtitle!, style: widget.subtitleStyle) : null,
      onTap: _handleChanged,
      horizontalTitleGap: 4,
    );

    return widget.withBorder
        ? DecoratedBox(
            decoration: BoxDecoration(
              border: Border.all(color: _animations[1].value, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: tile,
          )
        : tile;
  }
}
