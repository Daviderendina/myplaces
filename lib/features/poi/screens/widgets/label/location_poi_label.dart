import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/core/models/poi.dart';

class LocationPoiLabel extends StatelessWidget {
  final Poi poi;

  const LocationPoiLabel({super.key, required this.poi});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppLayout.spaces.horizontalXSmall,
      children: [
        CircleFlag(poi.countryCode, size: AppLayout.icons.xsmall),
        Text(poi.positionLabel, style: Theme.of(context).textTheme.bodySmall, maxLines: 1),
      ],
    );
  }
}
