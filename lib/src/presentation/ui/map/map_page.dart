import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar_plus/material_floating_search_bar_plus.dart';
import 'package:myplaces/src/presentation/ui/map/poi_bottom_sheet.dart';
import 'package:myplaces/src/tools/logger.dart';

import '../../../../../src/domain/poi.dart';
import '../../../providers.dart';
import 'mysearchbar.dart';

// TODO quando si cambia pagina bisogna fare il clean della mappa!!

class MapPage extends ConsumerWidget {
  final MapController mapController = MapController();
  final FloatingSearchBarController searchBarController =
      FloatingSearchBarController();

  MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapPageControllerProvider);
    final poi = ref.watch(selectedPoiControllerProvider);

    logger.info("Show marker: ${state.showPoiMarker}");
    logger.info("Poi to show: $poi");

    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
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
                if (poi != null && state.showPoiMarker)
                  Marker(
                    point: poi.coordinates,
                    child: GestureDetector(
                      onTap: () => showPoiModal(context),
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  ),
              ],
            ),

            //  Stadia.AlidadeSmoothDark - 3140b6e5-c3bd-4e46-9f53-6e482e3eab45
            //TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png', subdomains: ['a','b','c','d'], userAgentPackageName: 'com.example.app', )// si inchioda        TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', subdomains: const ['a', 'b', 'c', 'd'], userAgentPackageName: 'com.example.app', )
            // Scuro ni TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png', subdomains: ['a','b','c','d'], userAgentPackageName: 'com.example.app', )
          ],
        ),

        Positioned(
          top: 55,
          right: 65,
          child: Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: Colors.teal.withAlpha(190),
              borderRadius: BorderRadius.circular(16),
            ),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.filter_list_outlined,
                color: Colors.white,
                size: 23,
              ),
            ),
          ),
        ),

        MySearchBar(
          searchBarController: searchBarController,
          onResultTap: (r) => showPoiOnMap(context, ref, r),
        ),

        // Center(
        //   child: IconButton(
        //     onPressed: () {
        //       showPoiBottomSheet(
        //         Poi(
        //           name: "Parigi",
        //           city: "Paris",
        //           country: "France",
        //           countrycode: "FR",
        //           province: "Paris",
        //           id: "12",
        //           coordinates: LatLng(15, 15),
        //           categoryName: PoiCategory.city.name,
        //         ),
        //       );
        //     },
        //     icon: FlutterLogo(),
        //   ),
        // ),
      ],
    );
  }

  Future<void> showPoiOnMap(
    BuildContext context,
    WidgetRef ref,
    Poi poi,
  ) async {
    ref.read(selectedPoiControllerProvider.notifier).selectNewPoi(poi);

    showPoiModal(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mapPageControllerProvider.notifier).setPoiMarkerVisibility(true);

      // TODO zoom diverso per attrazione diversa, anzi meglio calcolo zoom in base ai markers che mi arrivano, chat sa come fare
      mapController.move(poi.coordinates, 15, offset: Offset(0, -200));
    });
  }

  Future<void> showPoiModal(BuildContext context) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => PoiBottomSheet(),
    );
  }
}
