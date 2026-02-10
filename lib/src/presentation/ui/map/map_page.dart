import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:material_floating_search_bar_plus/material_floating_search_bar_plus.dart';
import 'package:myplaces/src/presentation/ui/map/map_view.dart';
import 'package:myplaces/src/presentation/ui/map/poi_bottom_sheet.dart';
import 'package:myplaces/src/tools/logger.dart';

import '../../../../../src/domain/poi.dart';
import '../../../domain/my_list.dart';
import '../../../providers.dart';
import 'markers.dart';
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
    final lists = ref.watch(listsControllerProvider);

    logger.info("Show marker: ${state.showPoiMarker}");
    logger.info("Poi to show: $poi");

    return Stack(
      children: [
        // TODO all'inizio devo dargli una posizione e zoom predefiniti a queste
        MapView(
          controller: mapController,
          initialCenter: LatLng(43, 12.5),
          initialZoom: 5.55,
          markerBuilder: () {
            if (poi != null && state.showPoiMarker) {
              return [
                SelectedPoiMarker.build(
                  poi: poi,
                  onTap: () => showPoiModal(context),
                ),
              ];
            } else {
              return lists.when(
                data: (data) => buildShowedListsMarkers(context, data, ref),
                loading: () => [],
                error: (_, _) => [],
              );
            }
          },
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
      //mapController.move(poi.coordinates, 15, offset: Offset(0, -200));
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

  List<Marker> buildShowedListsMarkers(
    BuildContext context,
    List<MyList> lists,
    WidgetRef ref,
  ) {
    return lists
    //.where((l) => l.isDefault) //TODO sistemare il filtro
    .expand((list) {
      return list.poiList.map((poi) {
        return ListPoiMarker.build(
          myList: list,
          poi: poi,
          onTap: () => showPoiOnMap(context, ref, poi),
        );
      });
    }).toList();
  }
}
