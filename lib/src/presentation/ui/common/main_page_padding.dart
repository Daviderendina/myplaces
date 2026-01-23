import 'package:flutter/cupertino.dart';

class MainPagePadding extends StatelessWidget {
  final Widget child;

  const MainPagePadding({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
      child: this.child,
    );
  }
}
