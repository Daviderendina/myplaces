import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_floating_search_bar_plus/material_floating_search_bar_plus.dart';
import 'package:myplaces/components/map_page/floating_search.dart';
import 'package:myplaces/components/map_page/poi_detail_on_map.dart';
import 'package:myplaces/service/image_service.dart';

import '../models/poi.dart';
import '../providers.dart';

// TODO quando si cambia pagina bisogna fare il clean della mappa!!

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => MapPageState();
}

class MapPageState extends ConsumerState<MapPage> {
  late final MapController _mapController = MapController();
  late final FloatingSearchBarController _searchBarController =
      FloatingSearchBarController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(mapPageProvider);

    print("MArker to show: ${state.searchPoiResultToShow}");

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

            MarkerLayer(
              markers: [
                if (state.searchPoiResultToShow != null)
                  Marker(
                    point: state.searchPoiResultToShow!.coordinates,
                    child: GestureDetector(
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                      onTap: () =>
                          showPoiBottomSheet(state.searchPoiResultToShow!),
                    ),
                  ),
              ],
            ),

            // TODO non mi piace, forse il marker va gestito direttamente in riverpod?
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
              showPoiBottomSheet(
                Poi(
                  name: "Parigi",
                  city: "Paris",
                  country: "France",
                  province: "Paris",
                  id: "12",
                  coordinates: LatLng(15, 15),
                ),
              );
            },
            icon: FlutterLogo(),
          ),
        ),
      ],
    );
  }

  Poi getPoi(Poi poi) {
    return ref.read(poiRepositoryProvider).getById(poi.id) ?? poi;
  }

  void showPoiOnMap(Poi poi) {
    // TODO capire se e giusto farlo qui, forse non ha motlo senso
    poi = getPoi(poi);

    _searchBarController.close();

    ImageService().enrichPoiWithImages(poi: poi).whenComplete(() {
      print("H ${poi.images}");
      showPoiBottomSheet(poi);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mapPageProvider.notifier).showSearchPoiMarkerOnMap(poi);

      // TODO zoom diverso per attrazione diversa, anzi meglio calcolo zoom in base ai markers che mi arrivano, chat sa come fare
      _mapController.move(poi.coordinates, 15, offset: Offset(0, -200));
    });
  }

  void showPoiBottomSheet(Poi poi) {
    // TODO spostare questo nel notifier
    poi = getPoi(poi);

    /// TODO sta roba da spostare
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
                      children: [PoiDetailOnMap(poi: poi)],
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
