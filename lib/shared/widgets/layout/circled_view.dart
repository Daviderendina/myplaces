import 'package:flutter/material.dart';

class CircledView extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final double diameter;
  final Border? border;

  const CircledView({
    super.key,
    required this.child,
    required this.backgroundColor,
    required this.diameter,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: border,
      ),
      child: child,
    );
  }
}
