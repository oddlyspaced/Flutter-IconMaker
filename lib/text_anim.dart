import 'dart:async';
import 'package:flutter/material.dart';

class RotateAnimatedTextKit extends StatefulWidget {
  /// [String] that would be displayed subsequently in the animation.
  final String text;

  /// Gives [TextStyle] to the text strings.
  final TextStyle textStyle;

  /// Define the [Duration] of the pause between texts
  ///
  /// By default it is set to 500 milliseconds.
  final Duration pause;

  /// Override the [Duration] of the animation by setting the duration parameter.
  ///
  /// This will set the total duration for the animated widget.
  /// For example, if text = ["a", "b", "c"] and if you want that each animation
  /// should take 3 seconds then you have to set [duration] to 3 seconds.
  final Duration duration;

  /// Override the transition height by setting the value of parameter transitionHeight.
  ///
  /// By default it is set to [TextStyle.fontSize] * 10 / 3.
  final double transitionHeight;

  /// Adds the onTap [VoidCallback] to the animated widget.
  final VoidCallback onTap;

  /// Adds the onFinished [VoidCallback] to the animated widget.
  ///
  /// This method will run only if [isRepeatingAnimation] is set to false.
  final VoidCallback onFinished;

  /// Adds [AlignmentGeometry] property to the text in the widget.
  ///
  /// By default it is set to [Alignment.center]
  final AlignmentGeometry alignment;

  /// Specifies the [TextDirection] for resolving alignment.
  ///
  /// By default it is set to [TextDirection.ltr]
  final TextDirection textDirection;

  /// Adds [TextAlign] property to the text in the widget.
  ///
  /// By default it is set to [TextAlign.start]
  final TextAlign textAlign;

  /// Sets the number of times animation should repeat
  ///
  /// By default it is set to 3
  final int totalRepeatCount;

  /// Sets if the animation should repeat forever. [isRepeatingAnimation] also
  /// needs to be set to true if you want to repeat forever.
  ///
  /// By default it is set to false, if set to true, [totalRepeatCount] is ignored.
  final bool repeatForever;

  /// Set if the animation should not repeat by changing the value of it to false.
  ///
  /// By default it is set to true.
  final bool isRepeatingAnimation;

  /// Should the animation ends up early and display full text if you tap on it ?
  ///
  /// By default it is set to false.
  final bool displayFullTextOnTap;

  const RotateAnimatedTextKit({
    Key key,
    @required this.text,
    this.textStyle,
    this.transitionHeight,
    this.pause = const Duration(milliseconds: 500),
    this.onFinished,
    this.totalRepeatCount = 3,
    this.duration = const Duration(milliseconds: 2000),
    this.onTap,
    this.alignment = Alignment.center,
    this.textDirection = TextDirection.ltr,
    this.textAlign = TextAlign.start,
    this.displayFullTextOnTap = false,
    this.repeatForever = false,
    this.isRepeatingAnimation = true,
  })  : assert(null != text),
        assert(null != pause),
        assert(null != totalRepeatCount),
        assert(null != duration),
        assert(null != alignment),
        assert(null != textAlign),
        assert(null != displayFullTextOnTap),
        assert(null != repeatForever),
        assert(null != isRepeatingAnimation),
        super(key: key);

  @override
  _RotatingTextState createState() => _RotatingTextState();
}

class _RotatingTextState extends State<RotateAnimatedTextKit>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  double _transitionHeight;

  Animation<double> _fadeIn;
  Animation<Alignment> _slideIn;

  bool _isCurrentlyPausing = false;

  Timer _timer;

  int _currentRepeatCount;

  @override
  void initState() {
    super.initState();

    _transitionHeight =
        widget.transitionHeight ?? (widget.textStyle.fontSize * 10 / 3);

    _currentRepeatCount = 0;

    _initAnimation();
    _nextAnimation();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.stop();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textWidget = Text(
      widget.text,
      style: widget.textStyle,
      textAlign: widget.textAlign,
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _onTap,
      child: SizedBox(
        height: _transitionHeight,
        child: _isCurrentlyPausing || !_controller.isAnimating
            ? textWidget
            : AnimatedBuilder(
          animation: _controller,
          child: textWidget,
          builder: (BuildContext context, Widget child) {
            return AlignTransition(
              alignment: _slideIn,
              child: Opacity(
                opacity:
                _fadeIn.value,
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }

  void _initAnimation() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    final direction = widget.textDirection;

    _slideIn = AlignmentTween(
      begin: Alignment.topLeft.add(widget.alignment).resolve(direction),
      end: Alignment.centerLeft.add(widget.alignment).resolve(direction),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.linear),
      ),
    );

    _fadeIn = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _slideOut = AlignmentTween(
      begin: Alignment.centerLeft.add(widget.alignment).resolve(direction),
      end: Alignment.bottomLeft.add(widget.alignment).resolve(direction),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.linear),
      ),
    );

    _fadeOut = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    )..addStatusListener(_animationEndCallback);
  }

  void _nextAnimation() {
    _isCurrentlyPausing = false;

    if (widget.isRepeatingAnimation &&
        (widget.repeatForever ||
            _currentRepeatCount != (widget.totalRepeatCount - 1))) {
      if (!widget.repeatForever) {
        _currentRepeatCount++;
      }
    } else {
      widget.onFinished?.call();
      return;
    }

    if (mounted) setState(() {});

    _controller.forward(from: 0.0);
  }

  void _setPause() {

    _isCurrentlyPausing = true;
    if (mounted) setState(() {});
  }

  void _animationEndCallback(state) {
    if (state == AnimationStatus.completed) {
      assert(null == _timer || !_timer.isActive);
      _timer = Timer(widget.pause, _nextAnimation);
    }
  }

  void _onTap() {
    if (widget.displayFullTextOnTap) {
      if (_isCurrentlyPausing) {
        _timer?.cancel();
        _nextAnimation();
      } else {
        _controller?.stop();

        _setPause();

        assert(null == _timer || !_timer.isActive);
        _timer = Timer(widget.pause, _nextAnimation);
      }
    }

    widget.onTap?.call();
  }
}