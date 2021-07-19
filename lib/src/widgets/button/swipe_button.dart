library slide_to_confirm;

import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';

class SwipeButton extends StatefulWidget {
  final String? timer;
  final double? timerSize;
  final TextStyle? timerStyle;
  final double height;
  final double width;
  final Color? backgroundColor;
  final Color? disableBackgroundColor;
  final Color? replaceBackgroundColor;
  final Color? foregroundColor;
  final Color? iconColor;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double? iconSize;
  final String? text;
  final TextStyle? textStyle;
  final VoidCallback onConfirmation;
  final BorderRadius? foregroundRadius;
  final BorderRadius? backgroundRadius;
  final bool disable;

  const SwipeButton({
    Key? key,
    this.timer,
    this.timerSize,
    this.timerStyle,
    this.height = 48.0,
    this.width = 300,
    this.backgroundColor,
    this.disableBackgroundColor,
    this.foregroundColor,
    this.iconColor,
    this.leftIcon,
    this.text,
    this.textStyle,
    required this.onConfirmation,
    this.foregroundRadius,
    this.backgroundRadius,
    this.rightIcon,
    this.iconSize,
    this.replaceBackgroundColor,
    this.disable = false,
  });

  @override
  State<StatefulWidget> createState() {
    return SwipeButtonState();
  }
}

class SwipeButtonState extends State<SwipeButton> {
  double _position = 0;
  int _duration = 0;
  bool _isSwipe = false;

  double getPosition() {
    if (widget.disable) _position = 0;
    if (_position < 0) {
      return 0;
    } else if (_position > widget.width - widget.height) {
      return widget.width - widget.height;
    } else {
      return _position;
    }
  }

  Color? getColor() {
    if (!widget.disable) {
      if (_position > 0) {
        return widget.replaceBackgroundColor ?? HelperColors.green;
      } else {
        return widget.backgroundColor ?? HelperColors.orange;
      }
    } else {
      return widget.disableBackgroundColor ?? HelperColors.black9;
    }
  }

  void updatePosition(details) {
    if (!widget.disable) {
      if (details is DragEndDetails) {
        setState(() {
          _duration = 100;
          _position = _isSwipe ? widget.width : 0;
        });
      } else if (details is DragUpdateDetails) {
        setState(() {
          _duration = 0;
          _position = _isSwipe
              ? _position
              : details.localPosition.dx - (widget.height / 2);
        });
      }
    } else {
      _position = 0;
    }
  }

  void swipeReleased(details) {
    if (_position > widget.width - widget.height) {
      widget.onConfirmation();
      _isSwipe = true;
    }
    updatePosition(details);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        borderRadius: widget.backgroundRadius ??
            BorderRadius.all(Radius.circular(widget.height)),
        color: !widget.disable
            ? widget.backgroundColor ?? HelperColors.orange
            : HelperColors.black9,
      ),
      child: Stack(
        children: <Widget>[
          AnimatedContainer(
            height: widget.height,
            width: getPosition() + widget.height,
            duration: Duration(milliseconds: _duration),
            curve: Curves.bounceOut,
            decoration: BoxDecoration(
                borderRadius: widget.backgroundRadius ??
                    BorderRadius.all(Radius.circular(widget.height)),
                color: getColor()),
          ),
          Center(
            child: Text(
              widget.text ?? "Tugas Selesai",
              style: widget.textStyle ??
                  HelperThemeData.textTheme.buttonText1!
                      .copyWith(color: HelperColors.white),
            ),
          ),
          _isSwipe
              ? SizedBox()
              : Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      widget.timer ?? '00:00:00',
                      style: widget.timerStyle ??
                          HelperThemeData.textTheme.bodyText1!.copyWith(
                              fontSize: widget.timerSize ?? 12.0,
                              color: widget.disable
                                  ? HelperColors.black3
                                  : HelperColors.white),
                    ),
                  ),
                ),
          AnimatedPositioned(
            duration: Duration(milliseconds: _duration),
            curve: Curves.bounceOut,
            left: getPosition(),
            child: GestureDetector(
              onPanUpdate: (details) => updatePosition(details),
              onPanEnd: (details) => swipeReleased(details),
              child: !_isSwipe
                  ? Container(
                      height: widget.height,
                      width: widget.height,
                      decoration: BoxDecoration(
                        borderRadius: widget.foregroundRadius ??
                            BorderRadius.all(
                              Radius.circular(widget.height / 2),
                            ),
                        color: widget.foregroundColor ??
                            HelperColors.white.withOpacity(0.24),
                      ),
                      child: Icon(
                        widget.leftIcon ?? Icons.arrow_circle_up_rounded,
                        color: widget.iconColor ?? HelperColors.white,
                        size: widget.iconSize ?? 20.0,
                      ),
                    )
                  : Container(
                      height: widget.height,
                      width: widget.height,
                      decoration: BoxDecoration(
                        borderRadius: widget.foregroundRadius ??
                            BorderRadius.all(
                              Radius.circular(widget.height / 2),
                            ),
                        color: widget.foregroundColor ??
                            HelperColors.white.withOpacity(0.24),
                      ),
                      child: Icon(
                        widget.rightIcon ?? Icons.check_circle_rounded,
                        color: widget.iconColor ?? HelperColors.white,
                        size: widget.iconSize ?? 20.0,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
