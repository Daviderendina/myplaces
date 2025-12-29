import 'package:flutter/material.dart';

enum DefaultListElement {
  favourites("Preferiti", Icons.favorite, Colors.red),
  todo("Wishlist", Icons.pending, Colors.blue),
  visited("Visitati", Icons.check, Colors.green);

  final String label;
  final IconData icon;
  final Color color;

  const DefaultListElement(this.label, this.icon, this.color);
}
