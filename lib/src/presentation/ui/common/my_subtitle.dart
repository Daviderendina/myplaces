import 'package:flutter/material.dart';

class MySubtitle extends StatelessWidget {
  final String text;

  const MySubtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.w400,
        letterSpacing: 1.2,
        color: Colors.white,
        decorationColor: Color(0xff907AE6),
        decorationThickness: 2,
      ),
    );
  }
}
