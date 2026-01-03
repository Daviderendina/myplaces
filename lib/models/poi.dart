import 'dart:math';

import 'package:myplaces/config/poi_categories.dart';
import 'package:myplaces/models/poi_category.dart';

class Poi {
  final String id;

  final String? type;
  final String? subtype;

  final String name;

  final String? city;
  final String? province; // county?? tipo provincia
  final String? region; // state, cio`e regione
  final String? country;
  final String? countrycode;

  final PoiCategory? category;

  final Point<double>? coordinates;

  Poi({
    required this.id,
    this.type,
    this.subtype,
    required this.name,
    this.city,
    this.province,
    this.region,
    this.country,
    this.coordinates,
    this.countrycode,
    this.category,
  });

  bool isEmpty() {
    return id.isEmpty && name.isEmpty;
  }

  factory Poi.empty() {
    return Poi(id: '', name: '', category: PoiCategory.other);
  }

  factory Poi.fromJson(Map<String, dynamic> json) {
    try {
      final properties = json['properties'];
      final geometry = json['geometry'];

      return Poi(
        id: properties['osm_id'].toString(),
        type: properties['osm_key'],
        subtype: properties['osm_value'],
        name: properties['name'],
        city: properties['city'],
        province: properties['county'],
        region: properties['state'],
        country: properties['country'],
        countrycode: properties['countrycode'],
        coordinates: Point(
          geometry['coordinates'][0],
          geometry['coordinates'][1],
        ),
        category: findCategoryByTypeAndSubtype(
          properties['osm_key'],
          properties['osm_value'],
        ),
      );
    } catch (error) {
      print(error); // TODO
      return Poi.empty();
    }
  }
}

/*
{
ATTENZIONE perch`e posti diversi hanno campi diversi, alcuni sono nullable
      "type": "Feature",
      "properties": {
        "osm_type": "R",
        "": 62422,
        "": "place",
        "": "city",
        "type": "city",
        "countrycode": "DE",
        "": "Berlin",
        "": "Germany",
        "extent": [13.088345, 52.6755087, 13.7611609, 52.3382448]
      },
      "geometry": {
        "type": "Point",
        "coordinates": [13.3951309, 52.5173885]
      }
    },
* */
