import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import '../../../core/constants/AppLayout.dart';
import 'map_view.dart';

class MapViewCard extends StatelessWidget {
  final MapController controller;
  final List<Marker> Function() markerBuilder;

  const MapViewCard({super.key, required this.controller, required this.markerBuilder});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppLayout.map.cardRadius(context)),
      child: SizedBox(
        height: AppLayout.map.cardHeight(context),
        child: MapView(controller: controller, markerBuilder: markerBuilder),
      ),
    );
  }
}
