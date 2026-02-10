import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:myplaces/src/domain/my_list.dart';

import '../../../domain/poi.dart';
import '../list/visual_symbol_visualizer.dart';

class CircularFlagPoiMarker {
  static Marker build({required Poi poi, required VoidCallback onTap}) {
    return Marker(
      width: 32,
      height: 32,
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

class ListPoiMarker {
  static Marker build({
    required MyList myList,
    required Poi poi,
    required VoidCallback onTap,
  }) {
    return Marker(
      width: 32,
      height: 32,
      point: poi.coordinates,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withAlpha(180), //Colors.black.withAlpha(32),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: VisualSymbolVisualizer(symbol: myList.visualSymbol),
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
