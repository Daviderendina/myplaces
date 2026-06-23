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

  // TODO rivedere gli stili

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: AppLayout.getPagePadding(context),
          child: Column(
            spacing: 0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: AppLayout.space.getHorizontalSmall(context),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back, size: 25),
                    padding: EdgeInsets.symmetric(vertical: height * .0085),
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
                      SizedBox(
                        height: AppLayout.getMediumVerticalSpace(context),
                      ),
                      if (searchBar != null) ...[
                        searchBar!,
                        SizedBox(
                          height: AppLayout.getMediumVerticalSpace(context),
                        ),
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
