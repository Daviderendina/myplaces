import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  final String text;

  const MyTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 44,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.2,
          color: Colors.white,
          decorationColor: Color(0xff907AE6),
          decorationThickness: 2,
        ),
      ),
    );
  }
}
