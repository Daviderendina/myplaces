import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/collections/models/collection.dart';
import 'package:myplaces/shared/widgets/emoji/circled_emoji.dart';

import '../../../../core/models/poi.dart';

class AppMarker {
  static Marker selectedPoiMarker(Poi poi, BuildContext context) {
    return Marker(
      point: poi.coordinates,
      child: Icon(
        Icons.location_on,
        color: Theme.of(context).colorScheme.primary,
        size: AppLayout.icons.large,
      ),
    );
  }

  static Marker collectionPoiMarker(
    Poi poi,
    Collection collection,
    BuildContext context, {
    required VoidCallback onTap,
    required bool useCompactStyle,
  }) {
    final color = collection.emoji.color;

    return useCompactStyle
        ? Marker(
            point: poi.coordinates,
            width: AppLayout.markers.compactSize,
            height: AppLayout.markers.compactSize,
            child: GestureDetector(
              onTap: onTap,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withValues(alpha: .85),
                  border: Border.all(color: color.withValues(alpha: .95)),
                ),
                child: SizedBox(
                  width: AppLayout.markers.compactSize,
                  height: AppLayout.markers.compactSize,
                ),
              ),
            ),
          )
        : Marker(
            point: poi.coordinates,
            child: GestureDetector(
              onTap: onTap,
              child: CircledEmoji(collection: collection, addBorder: true),
            ),
          );
  }
}
