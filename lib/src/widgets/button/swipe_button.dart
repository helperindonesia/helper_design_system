library slide_to_confirm;

import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class SwipeButton extends StatefulWidget {
  const SwipeButton({
    Key? key,
    this.timer,
    this.timerSize,
    this.timerStyle,
    this.height = 48.0,
    this.width = 300,
    this.backgroundColor = HelperColors.orange,
    this.disableBackgroundColor = HelperColors.black8,
    this.replaceBackgroundColor = HelperColors.black8,
    this.iconColor = HelperColors.orange,
    this.leftIcon,
    required this.text,
    this.textStyle,
    required this.onConfirmation,
    this.foregroundRadius,
    this.backgroundRadius,
    this.rightIcon,
    this.iconSize,
    this.enabled = true,
    this.showLoadingIndicator = false,
  });

  final String? timer;
  final double? timerSize;
  final TextStyle? timerStyle;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? disableBackgroundColor;
  final Color? replaceBackgroundColor;
  final Color? iconColor;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final double? iconSize;
  final String text;
  final TextStyle? textStyle;
  final VoidCallback onConfirmation;
  final BorderRadius? foregroundRadius;
  final BorderRadius? backgroundRadius;
  final bool enabled;
  final bool showLoadingIndicator;

  @override
  State<SwipeButton> createState() => _SwipeButtonState();
}

class _SwipeButtonState extends State<SwipeButton> {
  double position = 0;
  int duration = 0;
  bool isSwiping = false;

  @override
  void initState() {
    super.initState();
    isSwiping = widget.showLoadingIndicator;
  }

  @override
  void didUpdateWidget(SwipeButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.showLoadingIndicator != widget.showLoadingIndicator) {
      if (!widget.showLoadingIndicator) position = 0;
      isSwiping = widget.showLoadingIndicator;
    }
  }

  double getPosition() {
    if (widget.showLoadingIndicator) position = widget.width;

    if (position < 0) {
      return 0;
    } else if (position > widget.width - widget.height) {
      return widget.width - widget.height;
    } else {
      return position;
    }
  }

  Color? getColor() {
    if (widget.enabled) {
      if (position > 0) {
        return widget.replaceBackgroundColor;
      } else {
        return widget.backgroundColor;
      }
    } else {
      return widget.disableBackgroundColor;
    }
  }

  void _updatePosition(details) {
    if (widget.enabled) {
      if (details is DragEndDetails) {
        debugPrint(details.primaryVelocity.toString());
        setState(() {
          duration = 100;
          position = isSwiping ? widget.width : 0;
        });
      } else if (details is DragUpdateDetails) {
        print(details.localPosition);
        setState(() {
          duration = 0;
          position = isSwiping
              ? position
              : details.localPosition.dx - (widget.height / 2);
        });
      }
    } else {
      position = 0;
    }
  }

  void _swipeReleased(details) {
    if (position > widget.width - widget.height) {
      if (!widget.showLoadingIndicator) widget.onConfirmation();
      isSwiping = true;
    }
    _updatePosition(details);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: widget.backgroundRadius ??
            BorderRadius.all(Radius.circular(widget.height)),
        color: widget.enabled ? widget.backgroundColor : HelperColors.black9,
      ),
      child: Stack(
        children: <Widget>[
          AnimatedContainer(
            height: widget.height,
            width: getPosition() + widget.height,
            duration: Duration(milliseconds: duration),
            curve: Curves.bounceOut,
            decoration: BoxDecoration(
              borderRadius: widget.backgroundRadius ??
                  BorderRadius.all(Radius.circular(widget.height)),
              color: getColor(),
            ),
          ),
          Center(
            child: Text(
              widget.text,
              style: widget.textStyle ??
                  HelperThemeData.textTheme.buttonText1!
                      .copyWith(color: HelperColors.white),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: duration),
            curve: Curves.bounceOut,
            left: getPosition(),
            child: GestureDetector(
              onPanUpdate: _updatePosition,
              onPanEnd: _swipeReleased,
              child: !isSwiping
                  ? Container(
                      height: widget.height,
                      width: widget.height,
                      decoration: BoxDecoration(
                        borderRadius: widget.foregroundRadius ??
                            BorderRadius.all(
                              Radius.circular(widget.height / 2),
                            ),
                        color: getColor(),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: HelperColors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(widget.height / 2)),
                        ),
                        child: widget.leftIcon ??
                            Icon(
                              HelperIcons.ic_arrow_right_circle,
                              color: widget.enabled
                                  ? widget.iconColor
                                  : HelperColors.black9,
                              size: widget.iconSize ?? 20.0,
                            ),
                      ))
                  : Container(
                      height: widget.height,
                      width: widget.height,
                      decoration: BoxDecoration(
                        borderRadius: widget.foregroundRadius ??
                            BorderRadius.all(
                              Radius.circular(widget.height / 2),
                            ),
                        color: getColor(),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: HelperColors.white,
                          borderRadius:
                              BorderRadius.circular(widget.height / 2),
                        ),
                        child: CircularProgressIndicator(
                          strokeWidth: 2.0,
                          color: getColor(),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
