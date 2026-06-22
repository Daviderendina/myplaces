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
                spacing: AppLayout.getSmallHorizontalSpace(context),
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: height * .0085),
                    // TODO mettere  nel layout
                    child: Icon(Icons.arrow_back, size: 25),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.headlineMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (subtitle != null)
                          Text(subtitle!, style: Theme.of(context).textTheme.headlineSmall),
                      ],
                    ),
                  ),
                  ?action,
                ],
              ),

              SizedBox(height: AppLayout.getMediumVerticalSpace(context)),
              if (searchBar != null) ...[
                searchBar!,
                SizedBox(height: AppLayout.getMediumVerticalSpace(context)),
              ],
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
