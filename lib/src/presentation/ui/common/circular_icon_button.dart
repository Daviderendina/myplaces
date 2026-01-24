import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CircularIconButton({
    super.key,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        color: Colors.white10,
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        color: Colors.white.withAlpha(200),
        onPressed: onPressed,
      ),
    );
  }
}
