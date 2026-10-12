import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppColors.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/core/models/poi.dart';

class VisitedPoiLabel extends StatelessWidget {
  final Poi poi;

  const VisitedPoiLabel({super.key, required this.poi});

  @override
  Widget build(BuildContext context) {
    if (poi.tripsBelonged.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      spacing: AppLayout.spaces.horizontalXSmall,
      children: [
        Text("Visited", style: Theme.of(context).textTheme.bodySmall, maxLines: 1),
        Icon(Icons.check_circle, size: AppLayout.icons.xsmall, color: AppColors.greenLight),
      ],
    );
  }
}
