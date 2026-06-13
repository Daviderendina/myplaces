import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  final double? width;
  final double? height;
  final VoidCallback? onTap;
  final Widget? child;

  const CustomBox({super.key, this.width, this.height, this.onTap, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: Material(
        color: Colors.grey.shade900.withAlpha(180),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
