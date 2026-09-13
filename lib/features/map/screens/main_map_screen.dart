import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/collections/models/collection.dart';
import 'package:myplaces/features/map/controllers/main_map_state.dart';
import 'package:myplaces/features/map/providers.dart';
import 'package:myplaces/features/map/screens/widgets/AppMarker.dart';
import 'package:myplaces/features/map/screens/widgets/poi_summary_sheet.dart';
import 'package:myplaces/features/map/screens/widgets/select_visible_lists_button.dart';
import 'package:myplaces/shared/widgets/app_search_bar_container.dart';

import '../../../core/models/poi.dart';
import '../../../shared/widgets/map/map_view_screen.dart';
import '../controllers/main_map_controller.dart';

class MainMapScreen extends ConsumerStatefulWidget {
  const MainMapScreen({super.key});

  @override
  ConsumerState<MainMapScreen> createState() => _MainMapScreenState();
}

class _MainMapScreenState extends ConsumerState<MainMapScreen> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  List<Marker> _buildMarkers(MainMapState mapState, MainMapController mapController) {
    // TODO perchè vien chiamata quando si esce dalla mappa e non solo quando si entra?
    final markers = <Marker>[];

    // Add selectedPoi marker
    if ((mapState.showSelectedPoiMarker ?? true) && mapState.selectedPoi != null) {
      markers.add(AppMarker.selectedPoiMarker(mapState.selectedPoi!, context));
    }

    // Add poi belonging to visible collections
    List<Marker> visibleCollectionsMarkers = mapState.visibleCollections
        .expand((Collection c) => c.pois)
        .map((Poi poi) {
          return AppMarker.collectionPoiMarker(
            poi,
            mapState.visibleCollections.firstWhere((c) => c.pois.contains(poi)),
            context,
            onTap: () => mapController.selectPoi(poi: poi, showSelectedPoiMarker: false),
          );
        })
        .toList();

    markers.addAll(visibleCollectionsMarkers);

    return markers;
  }

  @override
  Widget build(BuildContext context) {
    final MainMapState mapState = ref
        .watch(mainMapControllerProvider)
        .when(
          data: (state) => state,
          loading: () => const MainMapState(),
          error: (error, stackTrace) => const MainMapState(),
        );
    final mapController = ref.read(mainMapControllerProvider.notifier);

    ref.listen(mainMapControllerProvider, (previous, next) {
      final cameraState = next.when(
        data: (state) => state,
        loading: () => null,
        error: (error, stackTrace) => null,
      );
      final cameraMoveTarget = cameraState?.cameraMoveTarget;
      if (cameraMoveTarget != null) {
        _mapController.move(
          cameraMoveTarget,
          cameraState?.targetZoom ?? 7.0,
          offset: cameraState?.targetOffset ?? Offset.zero,
        );
      }
    });

    return Stack(
      children: [
        MapViewScreen(
          controller: _mapController,
          markerBuilder: () => _buildMarkers(mapState, mapController),
        ),
        if (mapState.selectedPoi != null)
          Positioned(
            left: AppLayout.geometry.mainPagePadding.left,
            right: AppLayout.geometry.mainPagePadding.right,
            bottom: AppLayout.screenHeight * .10,
            child: PoiSummarySheet(
              poi: mapState.selectedPoi!,
              onCloseClick: () => mapController.clearSelection(),
            ),
          ),

        Positioned(
          top: AppLayout.screenHeight * .05,
          right: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsets.only(
              right: AppLayout.geometry.mainPagePadding.right,
              left: AppLayout.geometry.mainPagePadding.left,
            ),
            child: Row(
              spacing: AppLayout.spaces.horizontalSmall,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppSearchBar(
                    height: AppLayout.geometry.itemHeightSmall,
                    readOnly: true,
                    leading: Icon(Icons.search, color: Theme.of(context).hintColor),
                    trailing: mapState.selectedPoi != null
                        ? Icon(Icons.close, color: Theme.of(context).hintColor)
                        : null,
                    onTrailingTap: () => mapController.clearSelection(),
                    hintText: 'Search..',
                    onTap: () => mapController.onSearchTap(context),
                  ),
                ),

                SelectVisibleListsButton(size: AppLayout.geometry.itemHeightSmall),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
