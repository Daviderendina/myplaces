import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';

class InfoPoiLabel extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoPoiLabel({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppLayout.spaces.horizontalXSmall,
      children: [
        Icon(
          icon,
          size: AppLayout.icons.small,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
