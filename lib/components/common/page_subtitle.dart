import 'package:flutter/material.dart';

class PageSubtitle extends StatelessWidget {
  final String text;

  const PageSubtitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 24),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
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
