import 'package:flutter/material.dart';

enum PoiCategory {
  country(icon: Icons.flag),
  geoarea(icon: Icons.explore),
  city(icon: Icons.location_city),
  food(icon: Icons.restaurant),
  tourism(icon: Icons.attractions),
  historic(icon: Icons.account_balance),
  culture(icon: Icons.museum),
  religion(icon: Icons.church),
  accommodation(icon: Icons.hotel),
  sport(icon: Icons.sports_soccer),
  hiking(icon: Icons.hiking),
  nature(icon: Icons.park),
  mountain(icon: Icons.landscape),
  water(icon: Icons.water),
  parking(icon: Icons.local_parking),
  transport(icon: Icons.directions_transit),
  shopping(icon: Icons.shopping_bag),
  other(icon: Icons.place),
  unknown(icon: Icons.question_mark);

  final IconData icon;

  const PoiCategory({required this.icon});
}
