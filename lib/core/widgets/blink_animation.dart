import 'package:flutter/material.dart';

class BlinkAnimation extends StatefulWidget {
  const BlinkAnimation({
    this.duration = const Duration(seconds: 2),
    this.curve = Curves.slowMiddle,
    required this.child,
    super.key,
  });

  final Duration duration;
  final Curve curve;
  final Widget child;

  @override
  State<BlinkAnimation> createState() => _BlinkAnimationState();
}

class _BlinkAnimationState extends State<BlinkAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _updateAnimation();
  }

  void _updateAnimation() {
    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void didUpdateWidget(BlinkAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.duration != widget.duration) {
      _controller
        ..duration = widget.duration
        ..reset()
        ..repeat(reverse: true);
    }

    if (oldWidget.curve != widget.curve) {
      setState(() {
        _updateAnimation();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}
