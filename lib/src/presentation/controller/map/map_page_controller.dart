import 'package:flutter_riverpod/legacy.dart';

import 'map_page_state.dart';

class MapPageController extends StateNotifier<MapPageState> {
  MapPageController(super._state);

  Future<void> setPoiMarkerVisibility(bool visibility) async {
    state = state.copyWith(showPoiMarker: visibility);
  }

  Future<void> clearMap() async {
    setPoiMarkerVisibility(false);
  }
}
