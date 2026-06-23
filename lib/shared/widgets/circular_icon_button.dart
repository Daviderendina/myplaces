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
    final size = MediaQuery.sizeOf(context).height * .045;
    final iconSize = size * .58;

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        color: Colors.white.withAlpha(100),
      ),
      child: IconButton(
        icon: Icon(icon, size: iconSize),
        color: Colors.black,
        onPressed: onPressed,
      ),
    );
  }
}
