import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum PoiCategory {
  country(icon: Icons.flag),
  geoarea(icon: Icons.explore),
  city(icon: Icons.location_city),
  food(icon: Icons.restaurant),
  sport(icon: Icons.sports_soccer),
  hiking(icon: Icons.hiking),
  parking(icon: Icons.local_parking),
  buildingReligious(icon: Icons.question_mark),
  mountain(icon: Icons.landscape),
  other(icon: Icons.question_mark), //TODO
  unknown(icon: Icons.question_mark);

  final IconData icon;

  const PoiCategory({required this.icon});
}

// TODO metteer qui una icon!!!
