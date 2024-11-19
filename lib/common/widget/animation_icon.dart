import 'package:flutter/material.dart';
import 'package:webordernft/config/palette.dart';

class AnimatedCheckIcon extends StatefulWidget {
  const AnimatedCheckIcon({Key? key}) : super(key: key);

  @override
  _AnimatedCheckIconState createState() => _AnimatedCheckIconState();
}

class _AnimatedCheckIconState extends State<AnimatedCheckIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Icon(
        Icons.check_circle,
        color: Palette.primary,
        size: 120,
      ),
    );
  }
}
