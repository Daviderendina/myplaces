import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'map_view.dart';

class MapViewScreen extends StatelessWidget {
  final MapController controller;
  final MarkerBuilder markerBuilder;
  final EdgeInsets? cameraPadding;

  const MapViewScreen({
    super.key,
    required this.controller,
    required this.markerBuilder,
    this.cameraPadding,
  });

  @override
  Widget build(BuildContext context) {
    return MapView(
      controller: controller,
      markerBuilder: markerBuilder,
      cameraPadding: cameraPadding,
    );
  }
}
