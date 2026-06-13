import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_box.dart';

class CustomTitledBox extends StatelessWidget {
  final double? width;
  final double? height;
  final String? title;
  final VoidCallback? onTap;
  final List<Widget>? children;

  const CustomTitledBox({
    super.key,
    this.width,
    this.height,
    this.title,
    this.onTap,
    this.children,
  });

  @override
  Widget build(BuildContext context) {
    return CustomBox(
      width: width,
      height: height,
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              title ?? "",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white.withAlpha(220),
              ),
            ),
          ),
          SizedBox(height: 10),
          if (children != null) ...children!,
          SizedBox(height: 6),
        ],
      ),
    );
  }
}
