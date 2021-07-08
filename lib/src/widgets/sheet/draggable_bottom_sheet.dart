import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/physics.dart';
import 'package:helper_design/helper_design.dart';

enum SlideDirection {
  UP,
  DOWN,
}

enum PanelState { OPEN, CLOSED }

class DraggableBottomSheet extends StatefulWidget {
  final Widget? panel;
  final Widget? body;
  final double minHeight;
  final double maxHeight;
  final double? snapPoint;
  final Border? border;
  final BorderRadiusGeometry? borderRadius;
  final List<BoxShadow>? boxShadow;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool renderPanelSheet;
  final bool panelSnapping;
  final PanelController? controller;
  final bool backdropEnabled;
  final Color backdropColor;
  final double backdropOpacity;
  final bool backdropTapClosesPanel;
  final void Function(double position)? onPanelSlide;
  final VoidCallback? onPanelOpened;
  final VoidCallback? onPanelClosed;
  final bool parallaxEnabled;
  final double parallaxOffset;
  final bool isDraggable;
  final SlideDirection slideDirection;
  final PanelState defaultPanelState;

  DraggableBottomSheet({
    Key? key,
    required this.panel,
    this.body,
    this.minHeight = 109.0,
    this.maxHeight = 1000.0,
    this.snapPoint,
    this.border,
    this.borderRadius,
    this.boxShadow,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.renderPanelSheet = true,
    this.panelSnapping = true,
    this.controller,
    this.backdropEnabled = false,
    this.backdropColor = Colors.black,
    this.backdropOpacity = 0.5,
    this.backdropTapClosesPanel = true,
    this.onPanelSlide,
    this.onPanelOpened,
    this.onPanelClosed,
    this.parallaxEnabled = false,
    this.parallaxOffset = 0.1,
    this.isDraggable = true,
    this.slideDirection = SlideDirection.UP,
    this.defaultPanelState = PanelState.CLOSED,
  })  : assert(panel != null),
        assert(0 <= backdropOpacity && backdropOpacity <= 1.0),
        assert(snapPoint == null || 0 < snapPoint && snapPoint < 1.0),
        super(key: key);

  @override
  _DraggableBottomSheetState createState() => _DraggableBottomSheetState();
}

class _DraggableBottomSheetState extends State<DraggableBottomSheet>
    with SingleTickerProviderStateMixin {
  late AnimationController _ac;
  late ScrollController _sc;

  bool _scrollingEnabled = false;
  VelocityTracker _vt = new VelocityTracker.withKind(PointerDeviceKind.touch);

  bool _isPanelVisible = true;

  @override
  void initState() {
    super.initState();

    _ac = new AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        value: widget.defaultPanelState == PanelState.CLOSED ? 0.0 : 1.0)
      ..addListener(() {
        if (widget.onPanelSlide != null) widget.onPanelSlide!(_ac.value);

        if (widget.onPanelOpened != null && _ac.value == 1.0)
          widget.onPanelOpened!();

        if (widget.onPanelClosed != null && _ac.value == 0.0)
          widget.onPanelClosed!();
      });

    _sc = new ScrollController();
    _sc.addListener(() {
      if (widget.isDraggable && !_scrollingEnabled) _sc.jumpTo(0);
    });

    widget.controller?._addState(this);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: widget.slideDirection == SlideDirection.UP
          ? Alignment.bottomCenter
          : Alignment.topCenter,
      children: <Widget>[
        widget.body != null
            ? AnimatedBuilder(
                animation: _ac,
                builder: (context, child) {
                  return Positioned(
                    top: widget.parallaxEnabled ? _getParallax() : 0.0,
                    child: child ?? SizedBox(),
                  );
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: widget.body,
                ),
              )
            : Container(),
        !widget.backdropEnabled
            ? Container()
            : GestureDetector(
                onVerticalDragEnd: widget.backdropTapClosesPanel
                    ? (DragEndDetails dets) {
                        if ((widget.slideDirection == SlideDirection.UP
                                    ? 1
                                    : -1) *
                                dets.velocity.pixelsPerSecond.dy >
                            0) _close();
                      }
                    : null,
                onTap: widget.backdropTapClosesPanel ? () => _close() : null,
                child: AnimatedBuilder(
                    animation: _ac,
                    builder: (context, _) {
                      return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: _ac.value == 0.0
                            ? null
                            : widget.backdropColor.withOpacity(
                                widget.backdropOpacity * _ac.value),
                      );
                    }),
              ),
        !_isPanelVisible
            ? Container()
            : _gestureHandler(
                child: AnimatedBuilder(
                  animation: _ac,
                  builder: (context, child) {
                    return Container(
                      height:
                          _ac.value * (widget.maxHeight - widget.minHeight) +
                              widget.minHeight,
                      margin: widget.margin,
                      padding: widget.padding,
                      decoration: widget.renderPanelSheet
                          ? BoxDecoration(
                              border: widget.border,
                              borderRadius: widget.borderRadius ??
                                  BorderRadius.vertical(
                                    top: Radius.circular(16.0),
                                  ),
                              boxShadow: widget.boxShadow ??
                                  const <BoxShadow>[
                                    BoxShadow(
                                      // blurRadius: 16.0,
                                      color: Color.fromRGBO(18, 44, 77, 0.08),
                                    )
                                  ],
                              color:
                                  widget.backgroundColor ?? HelperColors.white,
                            )
                          : null,
                      child: child,
                    );
                  },
                  child: Stack(
                    children: <Widget>[
                      //open panel
                      Positioned(
                          top: widget.slideDirection == SlideDirection.UP
                              ? 0.0
                              : null,
                          bottom: widget.slideDirection == SlideDirection.DOWN
                              ? 0.0
                              : null,
                          width: MediaQuery.of(context).size.width -
                              (widget.margin != null
                                  ? widget.margin!.horizontal
                                  : 0) -
                              (widget.padding != null
                                  ? widget.padding!.horizontal
                                  : 0),
                          child: Container(
                              height: widget.maxHeight,
                              child: Column(
                                children: [
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 12.0),
                                    height: 2.0,
                                    width: 42.0,
                                    decoration: BoxDecoration(
                                        color: HelperColors.black9,
                                        borderRadius:
                                            BorderRadius.circular(50.0)),
                                  ),
                                  widget.panel ?? Container(),
                                ],
                              ))),
                    ],
                  ),
                ),
              ),
      ],
    );
  }

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  double _getParallax() {
    if (widget.slideDirection == SlideDirection.UP)
      return -_ac.value *
          (widget.maxHeight - widget.minHeight) *
          widget.parallaxOffset;
    else
      return _ac.value *
          (widget.maxHeight - widget.minHeight) *
          widget.parallaxOffset;
  }

  Widget _gestureHandler({required Widget child}) {
    if (!widget.isDraggable) return child;

    if (widget.panel != null) {
      return GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails dets) =>
            _onGestureSlide(dets.delta.dy),
        onVerticalDragEnd: (DragEndDetails dets) =>
            _onGestureEnd(dets.velocity),
        child: child,
      );
    }

    return Listener(
      onPointerDown: (PointerDownEvent p) =>
          _vt.addPosition(p.timeStamp, p.position),
      onPointerMove: (PointerMoveEvent p) {
        _vt.addPosition(p.timeStamp,
            p.position); // add current position for velocity tracking
        _onGestureSlide(p.delta.dy);
      },
      onPointerUp: (PointerUpEvent p) => _onGestureEnd(_vt.getVelocity()),
      child: child,
    );
  }

  void _onGestureSlide(double dy) {
    if (!_scrollingEnabled) {
      if (widget.slideDirection == SlideDirection.UP)
        _ac.value -= dy / (widget.maxHeight - widget.minHeight);
      else
        _ac.value += dy / (widget.maxHeight - widget.minHeight);
    }
    if (_isPanelOpen && _sc.hasClients && _sc.offset <= 0) {
      setState(() {
        if (dy < 0) {
          _scrollingEnabled = true;
        } else {
          _scrollingEnabled = false;
        }
      });
    }
  }

  void _onGestureEnd(Velocity v) {
    double minFlingVelocity = 365.0;
    double kSnap = 8;

    if (_ac.isAnimating) return;

    if (_isPanelOpen && _scrollingEnabled) return;

    double visualVelocity =
        -v.pixelsPerSecond.dy / (widget.maxHeight - widget.minHeight);

    if (widget.slideDirection == SlideDirection.DOWN)
      visualVelocity = -visualVelocity;

    double d2Close = _ac.value;
    double d2Open = 1 - _ac.value;
    double d2Snap = ((widget.snapPoint ?? 3) - _ac.value).abs();
    double minDistance = min(d2Close, min(d2Snap, d2Open));

    if (v.pixelsPerSecond.dy.abs() >= minFlingVelocity) {
      if (widget.panelSnapping && widget.snapPoint != null) {
        if (v.pixelsPerSecond.dy.abs() >= kSnap * minFlingVelocity ||
            minDistance == d2Snap)
          _ac.fling(velocity: visualVelocity);
        else
          _flingPanelToPosition(widget.snapPoint!, visualVelocity);
      } else if (widget.panelSnapping) {
        _ac.fling(velocity: visualVelocity);
      } else {
        _ac.animateTo(
          _ac.value + visualVelocity * 0.16,
          duration: Duration(milliseconds: 410),
          curve: Curves.decelerate,
        );
      }

      return;
    }

    if (widget.panelSnapping) {
      if (minDistance == d2Close) {
        _close();
      } else if (minDistance == d2Snap) {
        _flingPanelToPosition(widget.snapPoint!, visualVelocity);
      } else {
        _open();
      }
    }
  }

  void _flingPanelToPosition(double targetPos, double velocity) {
    final Simulation simulation = SpringSimulation(
        SpringDescription.withDampingRatio(
          mass: 1.0,
          stiffness: 500.0,
          ratio: 1.0,
        ),
        _ac.value,
        targetPos,
        velocity);

    _ac.animateWith(simulation);
  }

  Future<void> _close() {
    return _ac.fling(velocity: -1.0);
  }

  Future<void> _open() {
    return _ac.fling(velocity: 1.0);
  }

  Future<void> _hide() {
    return _ac.fling(velocity: -1.0).then((x) {
      setState(() {
        _isPanelVisible = false;
      });
    });
  }

  Future<void> _show() {
    return _ac.fling(velocity: -1.0).then((x) {
      setState(() {
        _isPanelVisible = true;
      });
    });
  }

  Future<void> _animatePanelToPosition(double value,
      {Duration? duration, Curve curve = Curves.linear}) {
    assert(0.0 <= value && value <= 1.0);
    return _ac.animateTo(value, duration: duration, curve: curve);
  }

  Future<void> _animatePanelToSnapPoint(
      {Duration? duration, Curve curve = Curves.linear}) {
    assert(widget.snapPoint != null);
    return _ac.animateTo(widget.snapPoint!, duration: duration, curve: curve);
  }

  set _panelPosition(double value) {
    assert(0.0 <= value && value <= 1.0);
    _ac.value = value;
  }

  double get _panelPosition => _ac.value;

  bool get _isPanelAnimating => _ac.isAnimating;

  bool get _isPanelOpen => _ac.value == 1.0;

  bool get _isPanelClosed => _ac.value == 0.0;

  bool get _isPanelShown => _isPanelVisible;
}

class PanelController {
  _DraggableBottomSheetState? _panelState;

  void _addState(_DraggableBottomSheetState panelState) {
    this._panelState = panelState;
  }

  bool get isAttached => _panelState != null;

  Future<void> close() {
    assert(isAttached, "PanelController must be attached");
    return _panelState!._close();
  }

  Future<void> open() {
    assert(isAttached, "PanelController must be attached");
    return _panelState!._open();
  }

  Future<void> hide() {
    assert(isAttached, "PanelController must be attached");
    return _panelState!._hide();
  }

  Future<void> show() {
    assert(isAttached, "PanelController must be attached");
    return _panelState!._show();
  }

  Future<void> animatePanelToPosition(double value,
      {Duration? duration, Curve curve = Curves.linear}) {
    assert(isAttached, "PanelController must be attached");
    assert(0.0 <= value && value <= 1.0);
    return _panelState!
        ._animatePanelToPosition(value, duration: duration, curve: curve);
  }

  Future<void> animatePanelToSnapPoint(
      {Duration? duration, Curve curve = Curves.linear}) {
    assert(isAttached, "PanelController must be attached");
    assert(_panelState!.widget.snapPoint != null,
        "snapPoint property must not be null");
    return _panelState!
        ._animatePanelToSnapPoint(duration: duration, curve: curve);
  }

  set panelPosition(double value) {
    assert(isAttached, "PanelController must be attached");
    assert(0.0 <= value && value <= 1.0);
    _panelState!._panelPosition = value;
  }

  double get panelPosition {
    assert(isAttached, "PanelController must be attached");
    return _panelState!._panelPosition;
  }

  bool get isPanelAnimating {
    assert(isAttached, "PanelController must be attached");
    return _panelState!._isPanelAnimating;
  }

  bool get isPanelOpen {
    assert(isAttached, "PanelController must be attached");
    return _panelState!._isPanelOpen;
  }

  bool get isPanelClosed {
    assert(isAttached, "PanelController must be attached");
    return _panelState!._isPanelClosed;
  }

  bool get isPanelShown {
    assert(isAttached, "PanelController must be attached");
    return _panelState!._isPanelShown;
  }
}
