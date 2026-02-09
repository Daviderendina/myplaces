import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

typedef MarkerBuilder = List<Marker> Function();

class MapView extends StatelessWidget {
  final MapController controller;
  final MarkerBuilder markerBuilder;

  const MapView({
    super.key,
    required this.controller,
    required this.markerBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: controller,
      options: const MapOptions(initialZoom: 5),
      children: [
        // https://github.com/CartoDB/basemap-styles?tab=readme-ov-file
        // https://basemaps.cartocdn.com/#9/43.2069/11.1354

        // ALIDADE DARK - ho api rate quindi per ora tengo altro
        // urlTemplate:
        //     'https://tiles.stadiamaps.com/tiles/alidade_smooth_dark/{z}/{x}/{y}{r}.png?api_key={api_key}',
        // additionalOptions: {
        //   "api_key": "3140b6e5-c3bd-4e46-9f53-6e482e3eab45",
        // },
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'it.drendina.myplaces',
        ),

        MarkerLayer(markers: markerBuilder()),

        //  Stadia.AlidadeSmoothDark - 3140b6e5-c3bd-4e46-9f53-6e482e3eab45
        //TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png', subdomains: ['a','b','c','d'], userAgentPackageName: 'com.example.app', )// si inchioda        TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', subdomains: const ['a', 'b', 'c', 'd'], userAgentPackageName: 'com.example.app', )
        // Scuro ni TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png', subdomains: ['a','b','c','d'], userAgentPackageName: 'com.example.app', )
      ],
    );
  }
}
