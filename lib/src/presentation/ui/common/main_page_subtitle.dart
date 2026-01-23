import 'package:flutter/material.dart';

import 'my_subtitle.dart';

class MainPageSubtitle extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry padding;

  const MainPageSubtitle({
    super.key,
    required this.text,
    this.padding = const EdgeInsets.only(left: 24),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: MySubtitle(text: text),
    );
  }
}
