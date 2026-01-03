import 'package:flutter/material.dart';
import 'package:myplaces/models/poi_category.dart';

import '../models/poi.dart';

final categoriesIcon = {
  PoiCategory.country: Icons.flag,
  PoiCategory.geoarea: Icons.question_mark,
  PoiCategory.city: Icons.location_city,
  PoiCategory.food: Icons.restaurant,
  PoiCategory.other: Icons.pin_drop,
  PoiCategory.sport: Icons.sports_soccer,
  PoiCategory.hiking: Icons.hiking,
  PoiCategory.parking: Icons.local_parking,
  PoiCategory.buildingReligious: Icons.question_mark,
  PoiCategory.mountain: Icons.terrain,
};

getIconForPoi(Poi poi) {
  return categoriesIcon[poi.category] ?? categoriesIcon[PoiCategory.other];
}
