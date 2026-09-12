import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

typedef MarkerBuilder = List<Marker> Function();

class MapView extends StatefulWidget {
  final MapController controller;
  final MarkerBuilder markerBuilder;
  final LatLng? initialCenter;
  final double? initialZoom;
  final EdgeInsets? cameraPadding;

  const MapView({
    super.key,
    required this.controller,
    required this.markerBuilder,
    this.initialCenter,
    this.initialZoom,
    this.cameraPadding,
  });

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  static const double _defaultZoom = 5;
  bool _mapReady = false;
  List<LatLng> _lastPoints = [];

  @override
  Widget build(BuildContext context) {
    final markers = widget.markerBuilder();
    _maybeFitMap(markers);

    return FlutterMap(
      mapController: widget.controller,
      options: MapOptions(
        initialZoom: widget.initialZoom ?? _defaultZoom,
        minZoom: 3,
        initialCenter: widget.initialCenter ?? LatLng(0, 0),
        cameraConstraint: CameraConstraint.contain(
          bounds: LatLngBounds(const LatLng(-85, -180), const LatLng(85, 180)),
        ),
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
          pinchZoomThreshold: 1.5,
        ),
        onMapReady: () {
          if (widget.initialCenter == null) {
            _mapReady = true;
            Future.microtask(() {
              _maybeFitMap(markers, force: true);
            });
          }
        },
      ),
      children: [
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'it.drendina.myplaces',
        ),
        MarkerLayer(markers: markers),
      ],
    );
  }

  void _maybeFitMap(List<Marker> markers, {bool force = false}) {
    if (!_mapReady || markers.isEmpty) return;

    final points = markers.map((m) => m.point).toList();

    if (!force && _samePoints(points, _lastPoints)) return;

    _lastPoints = points;

    Future.microtask(() {
      if (mounted) _fitToPoints(points);
    });
  }

  bool _samePoints(List<LatLng> a, List<LatLng> b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  void _fitToPoints(List<LatLng> points) {
    if (points.isEmpty) return;

    final padding = widget.cameraPadding ?? const EdgeInsets.all(48);

    LatLngBounds bounds;
    if (points.length == 1) {
      bounds = LatLngBounds(points.first, points.first);
    } else {
      bounds = _boundsFromPoints(points);
    }

    widget.controller.fitCamera(
      CameraFit.bounds(bounds: bounds, padding: padding, maxZoom: 14),
    );
  }

  LatLngBounds _boundsFromPoints(List<LatLng> points) {
    var minLat = points.first.latitude;
    var maxLat = points.first.latitude;
    var minLng = points.first.longitude;
    var maxLng = points.first.longitude;

    for (final p in points.skip(1)) {
      minLat = min(minLat, p.latitude);
      maxLat = max(maxLat, p.latitude);
      minLng = min(minLng, p.longitude);
      maxLng = max(maxLng, p.longitude);
    }

    return LatLngBounds(LatLng(minLat, minLng), LatLng(maxLat, maxLng));
  }
}
