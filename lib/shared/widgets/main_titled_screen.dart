import 'package:flutter/material.dart';

class MainTitledScreen extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? action;
  final Widget? searchBar;

  const MainTitledScreen({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.action,
    this.searchBar,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;

    return SafeArea(
      bottom: false,
      child: Column(
        spacing: 0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              Spacer(),
              ?action,
            ],
          ),
          if (subtitle != null) ...[
            Text(subtitle!, style: Theme.of(context).textTheme.headlineSmall?.copyWith(height: 1)),
            SizedBox(height: height * 0.03),
          ],
          if (searchBar != null) ...[searchBar!, SizedBox(height: height * 0.03)],
          Expanded(child: child),
        ],
      ),
    );
  }
}
