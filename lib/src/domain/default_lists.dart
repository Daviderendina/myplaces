import 'package:flutter/material.dart';

enum DefaultListType {
  // TODO capire se esiste una gestione migliore

  wishlist(name: "wishlist", color: Colors.blue, icon: Icons.bookmark),
  visited(name: "visited", color: Colors.green, icon: Icons.flag),
  favourites(name: "favourites", color: Colors.red, icon: Icons.favorite),
  notSet(name: "", color: Colors.pinkAccent, icon: Icons.question_mark);

  final String name;
  final Color color; // Not Used
  final IconData icon;

  const DefaultListType({
    required this.name,
    required this.color,
    required this.icon,
  });

  static DefaultListType fromName(String name) {
    return DefaultListType.values.firstWhere(
      (e) => e.name == name,
      orElse: () => notSet,
    );
  }
}

// TODO usarla anche in fase di init
