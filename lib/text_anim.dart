import 'dart:async';
import 'package:flutter/material.dart';

class RotateAnimatedTextKit extends StatefulWidget {
  /// [String] that would be displayed subsequently in the animation.
  final String text;

  /// Gives [TextStyle] to the text strings.
  final TextStyle textStyle;

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

  const RotateAnimatedTextKit({
    Key key,
    @required this.text,
    this.textStyle,
    this.transitionHeight,
    this.onFinished,
    this.duration = const Duration(milliseconds: 2000),
    this.alignment = Alignment.center,
    this.textDirection = TextDirection.ltr,
    this.textAlign = TextAlign.start,
  })  : assert(null != text),
        assert(null != duration),
        assert(null != alignment),
        assert(null != textAlign),
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

  @override
  void initState() {
    super.initState();

    _transitionHeight =
        widget.transitionHeight ?? (widget.textStyle.fontSize * 10 / 3);

    _initAnimation();
    _nextAnimation();
  }

  @override
  void dispose() {
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
                      opacity: _fadeIn.value,
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
  }

  void _nextAnimation() {
    _isCurrentlyPausing = false;
    if (mounted) setState(() {});
    _controller.forward(from: 0.0);
  }
}
