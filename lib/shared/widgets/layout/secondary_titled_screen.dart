import 'package:flutter/material.dart';
import '../../../core/constants/AppLayout.dart';

class SecondaryTitledScreen extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final Widget? searchBar;
  final Widget? action;

  const SecondaryTitledScreen({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.action,
    this.searchBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: AppLayout.geometry.pagePadding,
          child: Column(
            spacing: 0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: AppLayout.spaces.horizontalSmall,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, size: 25),
                    padding: EdgeInsets.symmetric(vertical: AppLayout.screenHeight * .0085),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.displayMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subtitle != null)
                          Text(
                            subtitle!,
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                      ],
                    ),
                  ),
                  if (action != null) action!,
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: AppLayout.spaces.verticalMedium),
                      if (searchBar != null) ...[
                        searchBar!,
                        SizedBox(height: AppLayout.spaces.verticalMedium),
                      ],
                      child,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
