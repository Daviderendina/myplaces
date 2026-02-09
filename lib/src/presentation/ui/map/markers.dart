import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

import '../../../domain/poi.dart';

class CircularFlagPoiMarker {
  static Marker build({required Poi poi, required VoidCallback onTap}) {
    return Marker(
      width: 20,
      height: 20,
      point: poi.coordinates,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(20),
            color: Colors.black.withAlpha(80),
          ),
          child: CountryFlag.fromCountryCode(
            poi.countrycode ?? '',
            theme: const ImageTheme(shape: Circle()),
          ),
        ),
      ),
    );
  }
}

class SelectedPoiMarker {
  static Marker build({required Poi poi, required VoidCallback onTap}) {
    return Marker(
      point: poi.coordinates,
      child: GestureDetector(
        onTap: onTap,
        child: Icon(Icons.location_pin, color: Colors.red, size: 40),
      ),
    );
  }
}
