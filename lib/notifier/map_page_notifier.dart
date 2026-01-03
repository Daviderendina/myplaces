import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      // TODO capire, aggiungere campo error allo state e mostrare toast a UI
      //state = MapPageState(error: e.toString());
    }
  }
}
