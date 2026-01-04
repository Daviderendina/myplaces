import 'package:flutter/material.dart';

import 'list_element.dart';

enum DefaultListElement {
  todo(
    listElement: PlacesList(
      label: "Wishlist",
      icon: Icons.pending,
      color: Colors.blue,
    ),
  ),
  favourites(
    listElement: PlacesList(
      label: "Preferiti",
      icon: Icons.favorite,
      color: Colors.red,
    ),
  ),
  visited(
    listElement: PlacesList(
      label: "Visitati",
      icon: Icons.check_circle,
      color: Colors.green,
    ),
  );

  final PlacesList listElement;

  const DefaultListElement({required this.listElement});
}
