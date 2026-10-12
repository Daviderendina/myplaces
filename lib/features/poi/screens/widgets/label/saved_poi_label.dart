import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppColors.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/core/models/poi.dart';

class SavedPoiLabel extends StatelessWidget {
  final Poi poi;

  const SavedPoiLabel({super.key, required this.poi});

  @override
  Widget build(BuildContext context) {
    if (poi.collectionsBelonged.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      spacing: AppLayout.spaces.horizontalXSmall,
      children: [
        Text(
          "Saved in ${poi.collectionsBelonged.length} collections",
          style: Theme.of(context).textTheme.bodySmall,
          maxLines: 1,
        ),
        Icon(Icons.bookmark, size: AppLayout.icons.xsmall, color: AppColors.cyanLight),
      ],
    );
  }
}
