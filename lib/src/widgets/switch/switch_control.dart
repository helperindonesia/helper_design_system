import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class SwitchControl extends StatefulWidget {
  const SwitchControl({
    Key? key,
    required this.value,
    required this.onToggle,
    this.activeToggleColor = HelperColors.orange,
    this.inactiveToggleColor = HelperColors.black9,
    this.width = 44.0,
    this.height = 24.0,
    this.toggleSize = 20.0,
    this.borderRadius = 12.0,
    this.padding = 2.0,
    this.activeSwitchBorder,
    this.inactiveSwitchBorder,
    this.activeBorderColor = HelperColors.orange,
    this.inActiveBorderColor = HelperColors.black9,
    this.duration = const Duration(milliseconds: 300),
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
      duration: widget.duration,
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
      _toggleColor = widget.activeToggleColor!;
      _switchBorder = widget.activeSwitchBorder as Border? ??
          Border.all(color: widget.activeBorderColor!, width: 1);
    } else {
      _toggleColor = widget.inactiveToggleColor!;
      _switchBorder = widget.inactiveSwitchBorder as Border? ??
          Border.all(color: widget.inActiveBorderColor!, width: 1);
    }

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Container(
          width: widget.width,
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
                width: widget.width,
                height: widget.height,
                padding: EdgeInsets.all(widget.padding!),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.borderRadius!),
                  color: HelperColors.white,
                  border: _switchBorder,
                ),
                child: Container(
                  child: Align(
                    alignment: _toggleAnimation.value,
                    child: Container(
                      width: widget.toggleSize,
                      height: widget.toggleSize,
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
