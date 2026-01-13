import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;

  const PageTitle({
    super.key,
    required this.text,
    this.padding = const EdgeInsets.only(left: 24),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
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
