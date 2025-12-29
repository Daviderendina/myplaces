import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: const MapOptions(initialZoom: 5),
      children: [
        // https://github.com/CartoDB/basemap-styles?tab=readme-ov-file
        // https://basemaps.cartocdn.com/#9/43.2069/11.1354
        TileLayer(
          urlTemplate:
              'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c', 'd'],
          userAgentPackageName: 'com.example.app',
        ),
        //TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png', subdomains: ['a','b','c','d'], userAgentPackageName: 'com.example.app', )// si inchioda        TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', subdomains: const ['a', 'b', 'c', 'd'], userAgentPackageName: 'com.example.app', )
        // Scuro ni TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png', subdomains: ['a','b','c','d'], userAgentPackageName: 'com.example.app', )
      ],
    );
  }
}
