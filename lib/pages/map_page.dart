import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_floating_search_bar_plus/material_floating_search_bar_plus.dart';
import 'package:myplaces/components/map_page/floating_search.dart';
import 'package:myplaces/components/poi_detail_on_map.dart';

import '../models/poi.dart';
import '../providers.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => MapPageState();
}

class MapPageState extends ConsumerState<MapPage> {
  late final MapController _mapController = MapController();
  late final FloatingSearchBarController _searchBarController =
      FloatingSearchBarController();

  Marker? searchMarker;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mapPageProvider);

    return Stack(
      children: [
        FlutterMap(
          mapController: _mapController,
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

            MarkerLayer(markers: [?searchMarker]),
            //  Stadia.AlidadeSmoothDark - 3140b6e5-c3bd-4e46-9f53-6e482e3eab45
            //TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png', subdomains: ['a','b','c','d'], userAgentPackageName: 'com.example.app', )// si inchioda        TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', subdomains: const ['a', 'b', 'c', 'd'], userAgentPackageName: 'com.example.app', )
            // Scuro ni TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png', subdomains: ['a','b','c','d'], userAgentPackageName: 'com.example.app', )
          ],
        ),
        MyFloatingSearchBar(
          searchBarController: _searchBarController,
          isSearching: state.isSearching,
          searchResults: state.searchResults,
          onResultTap: (r) => {showPoiOnMap(r)},
        ),

        Center(
          child: IconButton(
            onPressed: () {
              showPoiBottomSheet();
            },
            icon: FlutterLogo(),
          ),
        ),
      ],
    );
  }

  void showPoiOnMap(Poi poi) {
    // TODO capire bene anche come si cancellano questi, direi alla chiusura della tab
    _searchBarController.close();

    print(
      "Moving map to ${poi.coordinates?.x.toString()}, ${poi.coordinates?.y.toString()}",
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final lng = poi.coordinates?.x ?? 41.9028;
      final lat = poi.coordinates?.y ?? 12.4964;
      LatLng point = LatLng(lat, lng);

      setState(() {
        searchMarker = Marker(
          point: point,
          child: Icon(Icons.location_pin, color: Colors.red, size: 40),
        );
      });

      _mapController.move(
        LatLng(lat, lng),
        15,
        offset: Offset(0, -200),
      ); // TODO zoom diverso per attrazione diversa, anzi meglio calcolo zoom in base ai markers che mi arrivano, chat sa come fare
    });

    showPoiBottomSheet();
  }

  void showPoiBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          expand: false,
          builder: (context, scrollController) {
            return ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              child: Container(
                decoration: BoxDecoration(color: Colors.black),
                child: Stack(
                  children: [
                    ListView(
                      // TODO se faccio altezza in base al numero di liste, cancellare questo widget e tenerla fissa
                      controller: scrollController,
                      children: [PoiDetailOnMap()],
                    ),

                    Positioned(
                      right: 12,
                      top: 12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        spacing: 0,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.fullscreen),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
