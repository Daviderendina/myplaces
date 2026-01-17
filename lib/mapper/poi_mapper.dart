import 'dart:math';

import 'package:latlong2/latlong.dart';
import 'package:myplaces/models/poi_category.dart';
import 'package:myplaces/src/tools/logger.dart';

import '../config/poi_categories.dart';
import '../models/poi.dart';

class PoiMapper {
  static Poi mapPoiFromPhoton(Map<String, dynamic> photonApiResponse) {
    //logger.info("Mapping response from Photon: $photonApiResponse");
    try {
      final properties = photonApiResponse['properties'];
      final geometry = photonApiResponse['geometry'];

      Poi result = Poi(
        id: properties['osm_id'].toString(),
        type: properties['osm_key'],
        subtype: properties['osm_value'],
        categoryName: findCategoryByTypeAndSubtype(
          properties['osm_key'],
          properties['osm_value'],
        ).name,
        name: properties['name'],
        city: properties['city'],
        province: properties['county'],
        region: properties['state'],
        country: properties['country'],
        countrycode: properties['countrycode'],
        lat: geometry['coordinates'][1],
        lng: geometry['coordinates'][0],
      );

      //logger.info("Mapped poi: $result");

      return result;
    } catch (error) {
      print(error); // TODO
      return Poi.empty();
    }
  }

  static PoiCategory findCategoryByTypeAndSubtype(String type, String subtype) {
    // TODO fare un configuration Service???
    return poiCategories["$type|$subtype"] ??
        poiCategories["$type|*"] ??
        PoiCategory.unknown;
  }
}
