import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Build the Scroll Thumb and label using the current configuration
typedef Widget ScrollThumbBuilder(
    Color backgroundColor,
    Animation<double> thumbAnimation,
    Animation<double> labelAnimation,
    double height, {
      Text labelText,
      BoxConstraints labelConstraints,
    });

/// Build a Text widget using the current scroll offset
typedef Text LabelTextBuilder(double offsetY);

/// A widget that will display a BoxScrollView with a ScrollThumb that can be dragged
/// for quick navigation of the BoxScrollView.
class DraggableScrollbar extends StatefulWidget {
  /// The view that will be scrolled with the scroll thumb
  final BoxScrollView child;

  /// A function that builds a thumb using the current configuration
  final ScrollThumbBuilder scrollThumbBuilder;

  /// The height of the scroll thumb
  final double heightScrollThumb;

  /// The background color of the label and thumb
  final Color backgroundColor;

  /// The amount of padding that should surround the thumb
  final EdgeInsetsGeometry padding;

  /// Determines how quickly the scrollbar will animate in and out
  final Duration scrollbarAnimationDuration;

  /// How long should the thumb be visible before fading out
  final Duration scrollbarTimeToFade;

  /// Build a Text widget from the current offset in the BoxScrollView
  final LabelTextBuilder labelTextBuilder;

  /// Determines box constraints for Container displaying label
  final BoxConstraints labelConstraints;

  /// The ScrollController for the BoxScrollView
  final ScrollController controller;

  /// Determines scrollThumb displaying. If you draw own ScrollThumb and it is true you just don't need to use animation parameters in [scrollThumbBuilder]
  final bool alwaysVisibleScrollThumb;

  DraggableScrollbar({
    Key key,
    this.alwaysVisibleScrollThumb = false,
    @required this.heightScrollThumb,
    @required this.backgroundColor,
    @required this.scrollThumbBuilder,
    @required this.child,
    @required this.controller,
    this.padding,
    this.scrollbarAnimationDuration = const Duration(milliseconds: 300),
    this.scrollbarTimeToFade = const Duration(milliseconds: 600),
    this.labelTextBuilder,
    this.labelConstraints,
  })  : assert(controller != null),
        assert(scrollThumbBuilder != null),
        assert(child.scrollDirection == Axis.vertical),
        super(key: key);

  DraggableScrollbar.rrect({
    Key key,
    Key scrollThumbKey,
    this.alwaysVisibleScrollThumb = false,
    @required this.child,
    @required this.controller,
    this.heightScrollThumb = 48.0,
    this.backgroundColor = Colors.white,
    this.padding,
    this.scrollbarAnimationDuration = const Duration(milliseconds: 300),
    this.scrollbarTimeToFade = const Duration(milliseconds: 600),
    this.labelTextBuilder,
    this.labelConstraints,
  })  : assert(child.scrollDirection == Axis.vertical),
        scrollThumbBuilder =
        _thumbRRectBuilder(scrollThumbKey, alwaysVisibleScrollThumb),
        super(key: key);

  @override
  _DraggableScrollbarState createState() => _DraggableScrollbarState();

  static buildScrollThumbAndLabel(
      {@required Widget scrollThumb,
        @required Color backgroundColor,
        @required Animation<double> thumbAnimation,
        @required Animation<double> labelAnimation,
        @required Text labelText,
        @required BoxConstraints labelConstraints,
        @required bool alwaysVisibleScrollThumb}) {
    var scrollThumbAndLabel = labelText == null
        ? scrollThumb
        : Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ScrollLabel(
          animation: labelAnimation,
          child: labelText,
          backgroundColor: backgroundColor,
          constraints: labelConstraints,
        ),
        scrollThumb,
      ],
    );

    if (alwaysVisibleScrollThumb) {
      return scrollThumbAndLabel;
    }
    return SlideFadeTransition(
      animation: thumbAnimation,
      child: scrollThumbAndLabel,
    );
  }

  static ScrollThumbBuilder _thumbRRectBuilder(
      Key scrollThumbKey, bool alwaysVisibleScrollThumb) {
    return (
        Color backgroundColor,
        Animation<double> thumbAnimation,
        Animation<double> labelAnimation,
        double height, {
          Text labelText,
          BoxConstraints labelConstraints,
        }) {
      final scrollThumb = Material(
        elevation: 4.0,
        child: Container(
          constraints: BoxConstraints.tight(
            Size(16.0, height),
          ),
        ),
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(7.0)),
      );

      return buildScrollThumbAndLabel(
        scrollThumb: scrollThumb,
        backgroundColor: backgroundColor,
        thumbAnimation: thumbAnimation,
        labelAnimation: labelAnimation,
        labelText: labelText,
        labelConstraints: labelConstraints,
        alwaysVisibleScrollThumb: alwaysVisibleScrollThumb,
      );
    };
  }
}

class ScrollLabel extends StatelessWidget {
  final Animation<double> animation;
  final Color backgroundColor;
  final Text child;

  final BoxConstraints constraints;
  static const BoxConstraints _defaultConstraints =
  BoxConstraints.tightFor(width: 72.0, height: 28.0);

  const ScrollLabel({
    Key key,
    @required this.child,
    @required this.animation,
    @required this.backgroundColor,
    this.constraints = _defaultConstraints,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Container(
        margin: EdgeInsets.only(right: 12.0),
        child: Material(
          elevation: 4.0,
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          child: Container(
            constraints: constraints ?? _defaultConstraints,
            alignment: Alignment.center,
            child: child,
          ),
        ),
      ),
    );
  }
}

class _DraggableScrollbarState extends State<DraggableScrollbar>
    with TickerProviderStateMixin {
  double _barOffset;
  double _viewOffset;
  bool _isDragInProcess;

  AnimationController _thumbAnimationController;
  Animation<double> _thumbAnimation;
  AnimationController _labelAnimationController;
  Animation<double> _labelAnimation;
  Timer _fadeoutTimer;

  @override
  void initState() {
    super.initState();
    _barOffset = 0.0;
    _viewOffset = 0.0;
    _isDragInProcess = false;

    _thumbAnimationController = AnimationController(
      vsync: this,
      duration: widget.scrollbarAnimationDuration,
    );

    _thumbAnimation = CurvedAnimation(
      parent: _thumbAnimationController,
      curve: Curves.fastOutSlowIn,
    );

    _labelAnimationController = AnimationController(
      vsync: this,
      duration: widget.scrollbarAnimationDuration,
    );

    _labelAnimation = CurvedAnimation(
      parent: _labelAnimationController,
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void dispose() {
    _thumbAnimationController.dispose();
    _fadeoutTimer?.cancel();
    super.dispose();
  }

  double get barMaxScrollExtent =>
      context.size.height - widget.heightScrollThumb;

  double get barMinScrollExtent => 0.0;

  double get viewMaxScrollExtent => widget.controller.position.maxScrollExtent;

  double get viewMinScrollExtent => widget.controller.position.minScrollExtent;

  @override
  Widget build(BuildContext context) {
    Widget labelText;
    if (widget.labelTextBuilder != null && _isDragInProcess) {
      labelText = widget.labelTextBuilder(
        _viewOffset + _barOffset + widget.heightScrollThumb / 2,
      );
    }

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification notification) {
              changePosition(notification);
            },
            child: Stack(
              children: <Widget>[
                RepaintBoundary(
                  child: widget.child,
                ),
                RepaintBoundary(
                    child: GestureDetector(
                      onVerticalDragStart: _onVerticalDragStart,
                      onVerticalDragUpdate: _onVerticalDragUpdate,
                      onVerticalDragEnd: _onVerticalDragEnd,
                      child: Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: _barOffset),
                        padding: widget.padding,
                        child: widget.scrollThumbBuilder(
                          widget.backgroundColor,
                          _thumbAnimation,
                          _labelAnimation,
                          widget.heightScrollThumb,
                          labelText: labelText,
                          labelConstraints: widget.labelConstraints,
                        ),
                      ),
                    )),
              ],
            ),
          );
        });
  }

  //scroll bar has received notification that it's view was scrolled
  //so it should also changes his position
  //but only if it isn't dragged
  changePosition(ScrollNotification notification) {
    if (_isDragInProcess) {
      return;
    }

    setState(() {
      if (notification is ScrollUpdateNotification) {
        _barOffset += getBarDelta(
          notification.scrollDelta,
          barMaxScrollExtent,
          viewMaxScrollExtent,
        );

        if (_barOffset < barMinScrollExtent) {
          _barOffset = barMinScrollExtent;
        }
        if (_barOffset > barMaxScrollExtent) {
          _barOffset = barMaxScrollExtent;
        }

        _viewOffset += notification.scrollDelta;
        if (_viewOffset < widget.controller.position.minScrollExtent) {
          _viewOffset = widget.controller.position.minScrollExtent;
        }
        if (_viewOffset > viewMaxScrollExtent) {
          _viewOffset = viewMaxScrollExtent;
        }
      }

      if (notification is ScrollUpdateNotification ||
          notification is OverscrollNotification) {
        if (_thumbAnimationController.status != AnimationStatus.forward) {
          _thumbAnimationController.forward();
        }

        _fadeoutTimer?.cancel();
        _fadeoutTimer = Timer(widget.scrollbarTimeToFade, () {
          _thumbAnimationController.reverse();
          _labelAnimationController.reverse();
          _fadeoutTimer = null;
        });
      }
    });
  }

  double getBarDelta(
      double scrollViewDelta,
      double barMaxScrollExtent,
      double viewMaxScrollExtent,
      ) {
    return scrollViewDelta * barMaxScrollExtent / viewMaxScrollExtent;
  }

  double getScrollViewDelta(
      double barDelta,
      double barMaxScrollExtent,
      double viewMaxScrollExtent,
      ) {
    return barDelta * viewMaxScrollExtent / barMaxScrollExtent;
  }

  void _onVerticalDragStart(DragStartDetails details) {
    setState(() {
      _isDragInProcess = true;
      _labelAnimationController.forward();
      _fadeoutTimer?.cancel();
    });
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      if (_thumbAnimationController.status != AnimationStatus.forward) {
        _thumbAnimationController.forward();
      }
      if (_isDragInProcess) {
        _barOffset += details.delta.dy;

        if (_barOffset < barMinScrollExtent) {
          _barOffset = barMinScrollExtent;
        }
        if (_barOffset > barMaxScrollExtent) {
          _barOffset = barMaxScrollExtent;
        }

        double viewDelta = getScrollViewDelta(
            details.delta.dy, barMaxScrollExtent, viewMaxScrollExtent);

        _viewOffset = widget.controller.position.pixels + viewDelta;
        if (_viewOffset < widget.controller.position.minScrollExtent) {
          _viewOffset = widget.controller.position.minScrollExtent;
        }
        if (_viewOffset > viewMaxScrollExtent) {
          _viewOffset = viewMaxScrollExtent;
        }
        widget.controller.jumpTo(_viewOffset);
      }
    });
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    _fadeoutTimer = Timer(widget.scrollbarTimeToFade, () {
      _thumbAnimationController.reverse();
      _labelAnimationController.reverse();
      _fadeoutTimer = null;
    });
    setState(() {
      _isDragInProcess = false;
    });
  }
}

class SlideFadeTransition extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;

  const SlideFadeTransition({
    Key key,
    @required this.animation,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => animation.value == 0.0 ? Container() : child,
      child: SlideTransition(
        position: Tween(
          begin: Offset(0.3, 0.0),
          end: Offset(0.0, 0.0),
        ).animate(animation),
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }
}