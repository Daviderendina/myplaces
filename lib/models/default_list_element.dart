import 'package:flutter/material.dart';

import 'list_element.dart';

enum DefaultListElement {
  favourites(
    listElement: PlacesList(
      label: "Preferiti",
      icon: Icons.favorite,
      color: Colors.red,
    ),
  ),
  todo(
    listElement: PlacesList(
      label: "Wishlist",
      icon: Icons.pending,
      color: Colors.blue,
    ),
  ),
  visited(
    listElement: PlacesList(
      label: "Visitati",
      icon: Icons.check,
      color: Colors.green,
    ),
  );

  final PlacesList listElement;

  const DefaultListElement({required this.listElement});
}
