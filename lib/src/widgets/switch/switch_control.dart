import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class SwitchControl extends StatefulWidget {
  const SwitchControl({
    Key? key,
    required this.value,
    required this.onToggle,
    this.activeToggleColor,
    this.inactiveToggleColor,
    this.width,
    this.height,
    this.toggleSize,
    this.borderRadius,
    this.padding,
    this.activeSwitchBorder,
    this.inactiveSwitchBorder,
    this.activeBorderColor,
    this.inActiveBorderColor,
    this.duration,
  }) : super(key: key);
  final bool? value;
  final ValueChanged<bool> onToggle;
  final Color? activeToggleColor;
  final Color? inactiveToggleColor;
  final double? width;
  final double? height;
  final double? toggleSize;
  final double? borderRadius;
  final double? padding;
  final BoxBorder? activeSwitchBorder;
  final BoxBorder? inactiveSwitchBorder;
  final Color? activeBorderColor;
  final Color? inActiveBorderColor;
  final Duration? duration;

  @override
  _SwitchControlState createState() => _SwitchControlState();
}

class _SwitchControlState extends State<SwitchControl>
    with SingleTickerProviderStateMixin {
  late Animation _toggleAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      value: widget.value! ? 1.0 : 0.0,
      duration: widget.duration ?? Duration(milliseconds: 300),
    );
    _toggleAnimation = AlignmentTween(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SwitchControl oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value == widget.value) return;

    if (widget.value!)
      _animationController.forward();
    else
      _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    Color _toggleColor = Colors.white;
    Border _switchBorder;

    if (widget.value!) {
      _toggleColor = widget.activeToggleColor ?? HelperColors.orange;
      _switchBorder = widget.activeSwitchBorder as Border? ??
          Border.all(
              color: widget.activeBorderColor ?? HelperColors.orange, width: 1);
    } else {
      _toggleColor = widget.inactiveToggleColor ?? HelperColors.black9;
      _switchBorder = widget.inactiveSwitchBorder as Border? ??
          Border.all(
              color: widget.inActiveBorderColor ?? HelperColors.black9,
              width: 1);
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: widget.width ?? 44.0,
          child: Align(
            child: GestureDetector(
              onTap: () {
                if (widget.value!)
                  _animationController.forward();
                else
                  _animationController.reverse();

                widget.onToggle(!widget.value!);
              },
              child: Container(
                width: widget.width ?? 44.0,
                height: widget.height ?? 24.0,
                padding: EdgeInsets.all(widget.padding ?? 2.0),
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(widget.borderRadius ?? 12.0),
                  color: HelperColors.white,
                  border: _switchBorder,
                ),
                child: Container(
                  child: Align(
                    alignment: _toggleAnimation.value,
                    child: Container(
                      width: widget.toggleSize ?? 20.0,
                      height: widget.toggleSize ?? 20.0,
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _toggleColor,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
