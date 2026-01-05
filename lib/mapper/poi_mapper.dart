import 'dart:math';

import 'package:latlong2/latlong.dart';
import 'package:myplaces/models/poi_category.dart';

import '../config/poi_categories.dart';
import '../models/poi.dart';

class PoiMapper {
  static Poi mapPoiFromPhoton(Map<String, dynamic> photonApiResponse) {
    try {
      final properties = photonApiResponse['properties'];
      final geometry = photonApiResponse['geometry'];

      return Poi(
        id: properties['osm_id'].toString(),
        type: properties['osm_key'],
        subtype: properties['osm_value'],
        category: findCategoryByTypeAndSubtype(
          properties['osm_key'],
          properties['osm_value'],
        ),
        name: properties['name'],
        city: properties['city'],
        province: properties['county'],
        region: properties['state'],
        country: properties['country'],
        countrycode: properties['countrycode'],
        coordinates: LatLng(
          geometry['coordinates'][1],
          geometry['coordinates'][0],
        ),
      );
    } catch (error) {
      print(error); // TODO
      return Poi.empty();
    }
  }

  static PoiCategory? findCategoryByTypeAndSubtype(
    String type,
    String subtype,
  ) {
    // TODO fare un configuration Service???
    print(">> findCategoryByTypeAndSubtype");
    print("type: ${type} - subtype: ${subtype}");
    print(poiCategories["$type|$subtype"]);
    print(poiCategories["$type|*"]);
    return poiCategories["$type|$subtype"] ?? poiCategories["$type|*"];
  }
}
