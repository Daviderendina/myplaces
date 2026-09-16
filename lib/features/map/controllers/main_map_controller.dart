import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/core/models/poi.dart';
import 'package:myplaces/core/providers.dart';
import 'package:myplaces/logger.dart';
import 'package:myplaces/features/collections/providers.dart';
import 'package:myplaces/features/collections/services/collections_service.dart';
import 'package:myplaces/features/map/controllers/main_map_state.dart';
import 'package:myplaces/features/map/providers.dart';
import 'package:myplaces/features/search/model/PoiSearchResult.dart';
import 'package:myplaces/features/search/providers.dart';

class MainMapController extends AsyncNotifier<MainMapState> {
  late final CollectionService _service;
  late final AppLogger _logger;
  PoiSearchResult? _pendingSearchResult;

  @override
  Future<MainMapState> build() async {
    _service = ref.read(mainMapCollectionsServiceProvider);
    _logger = ref.read(loggerProvider);

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
    final PoiSearchResult? result = await context.push<PoiSearchResult>('/search');
    if (result != null) {
      selectFromSearch(result);
    }
  }

  void selectFromSearch(PoiSearchResult result) {
    _loadPoiDetail(result);
  }

  void retryLoadPoiDetail() {
    final pendingResult = _pendingSearchResult;
    if (pendingResult != null) {
      _loadPoiDetail(pendingResult);
    }
  }

  Future<void> _loadPoiDetail(PoiSearchResult result) async {
    _pendingSearchResult = result;
    final currentState = state.value ?? const MainMapState();
    state = AsyncData(
      currentState.copyWith(clearSelectedPoi: true, selectedPoiStatus: PoiSelectionStatus.loading),
    );

    try {
      final service = ref.read(searchServiceProvider);
      final poi = await service.searchByIdAndType(result.osmType, result.id);
      selectPoi(poi: poi);
    } catch (e, st) {
      _logger.error('Failed to load POI detail: $e', MainMapController, error: e, stackTrace: st);
      state = AsyncData(state.requireValue.copyWith(selectedPoiStatus: PoiSelectionStatus.error));
    }
  }

  void selectPoi({required Poi poi, bool showSelectedPoiMarker = true}) {
    final currentState = state.value ?? const MainMapState();
    state = AsyncData(
      currentState.copyWith(
        selectedPoi: poi,
        showSelectedPoiMarker: showSelectedPoiMarker,
        selectedPoiStatus: PoiSelectionStatus.loaded,
        cameraMoveTarget: poi.coordinates,
        targetZoom: 7.0,
        targetOffset: Offset(0, -AppLayout.screenHeight * .22),
      ),
    );
  }

  void clearSelection() {
    _pendingSearchResult = null;
    final currentState = state.value ?? const MainMapState();
    state = AsyncData(
      currentState.copyWith(
        clearSelectedPoi: true,
        clearCameraTarget: true,
        selectedPoiStatus: PoiSelectionStatus.notSet,
      ),
    );
  }

  Future<void> updateVisibleCollections(List<String> visibleIds) async {
    await _service.setVisibleCollections(visibleIds.toSet());
  }
}
