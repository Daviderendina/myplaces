import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';

// Included always in the root page
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
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: AppLayout.getPagePadding(context),
        child: Column(
          spacing: 0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(title, style: Theme.of(context).textTheme.displayLarge),
                Spacer(),
                ?action,
              ],
            ),

            if (subtitle != null) ...[
              Text(
                subtitle!,
                style: Theme.of(
                  context,
                ).textTheme.titleSmall?.copyWith(height: 1),
              ),
              SizedBox(height: AppLayout.getMediumVerticalSpace(context)),
            ],
            if (searchBar != null) ...[
              searchBar!,
              SizedBox(height: AppLayout.getMediumVerticalSpace(context)),
            ],
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
