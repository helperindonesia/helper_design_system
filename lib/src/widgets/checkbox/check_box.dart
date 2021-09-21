import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class HCheckBox<T> extends StatefulWidget {
  const HCheckBox({
    Key? key,
    required this.value,
    required this.selectedValue,
    required this.onChanged,
    this.size = 24,
    this.withBorder = true,
    this.controlPositionedTop,
    this.controlPositionedBottom,
    this.controlPositionedLeft,
    this.controlPositionedRight,
    this.width,
    this.height,
    this.child,
    this.childPadding,
  }) : super(key: key);
  final T value;

  final List<T> selectedValue;

  final ValueChanged<T?> onChanged;

  final double size;

  final bool withBorder;

  final double? controlPositionedTop;

  final double? controlPositionedBottom;

  final double? controlPositionedLeft;

  final double? controlPositionedRight;

  final double? width;

  final double? height;

  final Widget? child;

  final EdgeInsetsGeometry? childPadding;

  bool get _selected => selectedValue.contains(value);

  @override
  _HCheckBoxState createState() => _HCheckBoxState<T>();
}

class _HCheckBoxState<T> extends State<HCheckBox<T>>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation> _animations;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    _animations = [
      CurvedAnimation(parent: _controller, curve: Curves.ease),
      ColorTween(
        begin: HelperColors.black9,
        end: HelperColors.orange,
      ).animate(_controller),
      ColorTween(
        begin: HelperColors.black10,
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
  void didUpdateWidget(covariant HCheckBox<T> oldWidget) {
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

    final Widget control = InkWell(
      onTap: _handleChanged,
      child: AnimatedContainer(
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
      ),
    );

    return widget.withBorder
        ? Container(
            height: widget.height,
            width: widget.width ?? MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(color: _animations[2].value, width: 0.75),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                Container(
                  padding: widget.childPadding,
                  child: widget.child,
                ),
                Positioned(
                    top: widget.controlPositionedTop ?? 8,
                    bottom: widget.controlPositionedBottom,
                    left: widget.controlPositionedLeft,
                    right: widget.controlPositionedRight ?? 8,
                    child: control),
              ],
            ),
          )
        : control;
  }
}
