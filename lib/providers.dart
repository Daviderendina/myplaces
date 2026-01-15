import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/notifier/map_page_notifier.dart';
import 'package:myplaces/notifier/saved_page_notifier.dart';
import 'package:myplaces/repository/config_repository.dart';
import 'package:myplaces/repository/list_repository.dart';
import 'package:myplaces/repository/poi_repository.dart';
import 'package:myplaces/repository/poi_repository.dart';
import 'package:myplaces/service/list_service.dart';
import 'package:myplaces/service/poi_search_service.dart';
import 'package:myplaces/service/poi_service.dart';
import 'package:myplaces/state/map_page_state.dart';

import 'models/my_list.dart';
import 'models/poi.dart';
import 'notifier/my_lists_notifier.dart';
import 'objectbox.g.dart';

final appInitProvider = FutureProvider<void>((ref) async {
  // Create default lists
  ListService listService = ref.read(listServiceProvider);
  ref
      .read(configRepositoryProvider)
      .getDefaultLists()
      .where((l) => !listService.listExists(l))
      .map((l) => listService.save(l))
      .toList();
});

// States provider
final mapPageProvider =
    StateNotifierProvider<MapPageNotifier, MapPageViewState>(
      (ref) => MapPageNotifier(ref.read(poiRepositoryProvider)),
    );
final savedPageProvider =
    AsyncNotifierProvider<SavedPageNotifier, List<MyList>>(
      SavedPageNotifier.new,
    );
final selectedPoiProvider = StateProvider<Poi?>((ref) => null);
final selectedListProvider = StateProvider<MyList?>((ref) => null);

final myListsProvider = StateNotifierProvider<MyListsNotifier, List<MyList>>(
  (ref) => MyListsNotifier(ref.read(myListRepositoryProvider)),
);

// Repository
final poiRepositoryProvider = Provider<PoiRepository>(
  (ref) => PoiRepository(
    ref.read(poiSearchServiceProvider),
    ref.read(poiServiceProvider),
  ),
);
final myListRepositoryProvider = Provider<ListRepository>(
  (ref) => ListRepository(ref.read(listServiceProvider)),
);
final configRepositoryProvider = Provider<ConfigRepository>(
  (ref) => ConfigRepository(),
);

// Service
final listServiceProvider = Provider<ListService>(
  (ref) => ListService(ref.read(myListBoxProvider)),
);
final poiSearchServiceProvider = Provider<PoiSearchService>(
  (ref) => PoiSearchService(),
);
final poiServiceProvider = Provider<PoiService>(
  (ref) => PoiService(ref.read(poiBoxProvider)),
);

// Database
final myListBoxProvider = Provider<Box<MyList>>((ref) {
  final store = ref.read(objectBoxStoreProvider);
  return store.box<MyList>();
});
final poiBoxProvider = Provider<Box<Poi>>((ref) {
  final store = ref.read(objectBoxStoreProvider);
  return store.box<Poi>();
});

final objectBoxStoreProvider = Provider<Store>((ref) {
  throw UnimplementedError(
    "Override con lo Store reale in main() prima di runApp()",
  );
});
