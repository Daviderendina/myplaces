import 'package:flutter/material.dart';

class MainTitledScreen extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? action;

  const MainTitledScreen({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height; // TODO fare questo per tutti

    return SafeArea(
      bottom: false,
      child: Column(
        spacing: 0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: Theme.of(context).textTheme.headlineLarge),
              Spacer(),
              ?action,
            ],
          ),
          if (subtitle != null) ...[
            Text(subtitle!, style: Theme.of(context).textTheme.headlineSmall?.copyWith(height: 1)),
            SizedBox(height: height * 0.03),
          ],
          Expanded(child: child),
        ],
      ),
    );
  }
}
