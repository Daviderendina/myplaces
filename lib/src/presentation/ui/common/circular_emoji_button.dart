import 'package:flutter/material.dart';

class CircularEmojiButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String emoji;
  final bool isActive;

  const CircularEmojiButton({
    super.key,
    this.onPressed,
    required this.emoji,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: 38,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(80),
        color: Colors.grey.withAlpha(20),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size(38, 38),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          emoji,
          style: TextStyle(
            fontSize: 22,
            color: Colors.white.withAlpha(isActive ? 255 : 70),
          ),
        ),
      ),
    );
  }
}
