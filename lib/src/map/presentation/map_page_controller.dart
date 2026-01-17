import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/repository/poi_repository.dart';
import 'package:myplaces/src/tools/logger.dart';

import '../../../models/poi.dart';
import 'map_page_state.dart';

class MapPageController extends StateNotifier<MapPageState> {
  final PoiRepository repository;

  MapPageController(super._state, this.repository);

  Future<void> showPoiDetailOnMap(Poi poiToShow) async {
    logger.info("Showing detail for ${poiToShow.name} / ${poiToShow.id}");

    Poi poiToConsider = repository.getById(poiToShow.id) ?? poiToShow;

    state = state.copyWith(poiToShow: poiToConsider, showPoiMarker: true);
  }
}
