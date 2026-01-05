import 'dart:math';

import 'package:latlong2/latlong.dart';
import 'package:myplaces/models/poi_category.dart';
import 'package:myplaces/models/poi_image.dart';

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

  final LatLng coordinates;

  final List<PoiImage> images;

  Poi({
    required this.id,
    this.type,
    this.subtype,
    required this.name,
    this.city,
    this.province,
    this.region,
    this.country,
    required this.coordinates,
    this.countrycode,
    this.category,
    List<PoiImage>? images,
  }) : images = images ?? [];

  bool isEmpty() {
    return id.isEmpty && name.isEmpty;
  }

  factory Poi.empty() {
    return Poi(
      id: '',
      name: '',
      category: PoiCategory.other,
      coordinates: LatLng(0, 0),
    );
  }

  String getDisplayAreaName() {
    String location = [
      if (city != null && city!.isNotEmpty) city,
      if (province != null && province!.isNotEmpty) province,
    ].join(', ');

    return location.isEmpty ? "$country" : "$location · $country";
  }
}
