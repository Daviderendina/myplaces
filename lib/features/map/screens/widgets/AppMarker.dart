import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:myplaces/core/constants/AppLayout.dart';

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
}
