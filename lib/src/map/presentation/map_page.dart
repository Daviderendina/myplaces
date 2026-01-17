import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_floating_search_bar_plus/material_floating_search_bar_plus.dart';
import 'package:myplaces/src/map/presentation/mysearchbar.dart';
import 'package:myplaces/components/map_page/poi_detail_on_map.dart';
import 'package:myplaces/models/poi_category.dart';
import 'package:myplaces/functions/poi_detail_page/poi_detail_page.dart';
import 'package:myplaces/service/image_service.dart';
import 'package:myplaces/src/map/presentation/poi_bottom_sheet.dart';

import '../../../models/poi.dart';
import '../../../providers.dart';

// TODO quando si cambia pagina bisogna fare il clean della mappa!!

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final MapController mapController = MapController();
    late final FloatingSearchBarController searchBarController =
        FloatingSearchBarController();

    final state = ref.watch(mapPageControllerProvider);

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
                if (state.poiToShow != null && state.showPoiMarker)
                  Marker(
                    point: state.poiToShow!.coordinates,
                    child: GestureDetector(
                      child: Icon(
                        Icons.location_pin,
                        color: Colors.red,
                        size: 40,
                      ),
                      onTap: () {}, // TODO mostra modale via ref
                    ),
                  ),
              ],
            ),

            //  Stadia.AlidadeSmoothDark - 3140b6e5-c3bd-4e46-9f53-6e482e3eab45
            //TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png', subdomains: ['a','b','c','d'], userAgentPackageName: 'com.example.app', )// si inchioda        TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', subdomains: const ['a', 'b', 'c', 'd'], userAgentPackageName: 'com.example.app', )
            // Scuro ni TileLayer( urlTemplate: 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}.png', subdomains: ['a','b','c','d'], userAgentPackageName: 'com.example.app', )
          ],
        ),
        MySearchBar(
          searchBarController: searchBarController,
          onResultTap: (r) => showPoiOnMap(ref, r),
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

  void showPoiOnMap(WidgetRef ref, Poi poi) {
    //print("Showing poi on map: ${poi.name}");
    ref.read(mapPageControllerProvider.notifier).showPoiDetailOnMap(poi);
    // TODO qui devo usare due notifier, uno per il marker e l'altro per il poi
    showPoiModal();

    // TODO
    // ImageService().enrichPoiWithImages(poi: poi).whenComplete(() {
    //   print("H ${poi.images}");
    //   showPoiBottomSheet(poi);
    // });

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   ref.read(mapPageProvider.notifier).showSearchPoiMarkerOnMap(poi);
    //
    //   // TODO zoom diverso per attrazione diversa, anzi meglio calcolo zoom in base ai markers che mi arrivano, chat sa come fare
    //   _mapController.move(poi.coordinates, 15, offset: Offset(0, -200));
    // });
  }

  void showPoiModal(BuildContext context, Poi poi) {
    // in futuro questo poi arriva da riverpod diretto
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => PoiBottomSheet(
          poi: poi,
        ), // TOO qui devo usare riverpod con il selectedPoi ?? A questo punto forse lo uso anche per il poi da mostrare, cosi centralizzo anche il recupero da DB
      );
    });
  }
}
