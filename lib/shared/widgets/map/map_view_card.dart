import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'map_view.dart';

class MapViewCard extends StatelessWidget {
  final MapController controller;
  final List<Marker> Function() markerBuilder;
  final double height;

  const MapViewCard({
    super.key,
    required this.controller,
    required this.markerBuilder,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        height: height,
        child: MapView(controller: controller, markerBuilder: markerBuilder),
      ),
    );
  }
}
