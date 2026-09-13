import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/core/models/poi.dart';
import 'package:myplaces/features/collections/providers.dart';
import 'package:myplaces/features/collections/services/collections_service.dart';
import 'package:myplaces/features/map/controllers/main_map_state.dart';
import 'package:myplaces/features/map/providers.dart';

class MainMapController extends AsyncNotifier<MainMapState> {
  late final CollectionService _service;

  @override
  Future<MainMapState> build() async {
    _service = ref.read(mainMapCollectionsServiceProvider);

    ref.listen(collectionsStreamProvider, (_, next) {
      next.whenData((collections) {
        final visibleCollections = collections
            .where((collection) => collection.visibleOnMap)
            .toList();

        final currentState = state.value ?? const MainMapState();
        state = AsyncData(currentState.copyWith(visibleCollections: visibleCollections));
      });
    });

    final visibleCollections = await _service.fetchAllVisible();
    return MainMapState(visibleCollections: visibleCollections);
  }

  Future<void> onSearchTap(BuildContext context) async {
    final Poi? result = await context.push<Poi>('/search');
    if (result != null) {
      selectPoi(poi: result);
    }
  }

  void selectPoi({required Poi poi, bool showSelectedPoiMarker = true}) {
    final currentState = state.value ?? const MainMapState();
    state = AsyncData(
      currentState.copyWith(
        selectedPoi: poi,
        showSelectedPoiMarker: showSelectedPoiMarker,
        cameraMoveTarget: poi.coordinates,
        targetZoom: 7.0,
        targetOffset: Offset(0, -AppLayout.screenHeight * .22),
      ),
    );
  }

  void clearSelection() {
    final currentState = state.value ?? const MainMapState();
    state = AsyncData(currentState.copyWith(clearSelectedPoi: true, clearCameraTarget: true));
  }

  Future<void> updateVisibleCollections(List<String> visibleIds) async {
    await _service.setVisibleCollections(visibleIds.toSet());
  }
}
