import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PoiCategory {
  country(icon: Icons.flag, asset: "assets/images_poi_category/geoarea.png"),
  geoarea(icon: Icons.explore, asset: "assets/images_poi_category/geoarea.png"),
  city(icon: Icons.location_city, asset: "assets/images_poi_category/city.png"),
  food(
    icon: Icons.restaurant,
    asset: "assets/images_poi_category/restaurant.png",
  ),
  sport(
    icon: Icons.sports_soccer,
    asset: "assets/images_poi_category/touristplace.png",
  ),
  hiking(icon: Icons.hiking, asset: "assets/images_poi_category/mountain.png"),
  parking(
    icon: Icons.local_parking,
    asset: "assets/images_poi_category/parking.png",
  ),
  buildingReligious(
    icon: Icons.question_mark,
    asset: "assets/images_poi_category/touristplace.png",
  ),
  mountain(
    icon: Icons.landscape,
    asset: "assets/images_poi_category/mountain.png",
  ),
  other(
    icon: Icons.question_mark,
    asset: "assets/images_poi_category/city.png",
  ), //TODO
  unknown(
    icon: Icons.question_mark,
    asset: "assets/images_poi_category/city.png",
  ); // TODO

  final IconData icon;
  final String asset;

  const PoiCategory({required this.icon, required this.asset});
}

// TODO metteer qui una icon!!!
