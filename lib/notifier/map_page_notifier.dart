import 'package:flutter_riverpod/legacy.dart';

import '../models/poi.dart';
import '../repository/poi_repository.dart';
import '../state/map_page_state.dart';

class MapPageNotifier extends StateNotifier<MapPageViewState> {
  final PoiRepository repository;

  MapPageNotifier(this.repository) : super(const MapPageViewState());

  void search(String query) async {
    print("Start norifier: $query");

    if (query.isEmpty) {
      state = state.copyWith(searchResults: []);
      return;
    } else {
      print("Searching: $query");
      state = state.copyWith(searchResults: [], isSearching: true);
    }

    try {
      final res = await repository.search(query);
      state = state.copyWith(isSearching: false, searchResults: res);
    } catch (e) {
      print(e.toString());
      // TODO capire, aggiungere campo error allo state e mostrare toast a functions
      //state = MapPageState(error: e.toString());
    }
  }

  // TODO qui dentro gestire anche il Poi da mostrare nella tab sotto? LA ricerca aggiorna questo valore, e poi viene mostrata la modal quando si ricera il widget!!!

  void showSearchPoiMarkerOnMap(Poi poi) {
    print("Show MARKER");
    state = state.copyWith(searchPoiResultToShow: poi);
  }

  void clearMap() {
    print("hide MARKER");
    state = state.copyWith(searchPoiResultToShow: null);
  }
}
