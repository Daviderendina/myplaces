import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/shared/widgets/layout/circled_view.dart';

class SearchResultTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  const SearchResultTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircledView(
        diameter: AppLayout.icons.large,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: Icon(
          icon,
          size: AppLayout.icons.medium,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
      title: Text(title, style: Theme.of(context).textTheme.labelMedium),
      subtitle: Text(subtitle, style: Theme.of(context).textTheme.labelSmall),
      onTap: onTap,
    );
  }
}
