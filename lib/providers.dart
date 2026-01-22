import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/notifier/saved_page_notifier.dart';
import 'package:myplaces/repository/config_repository.dart';
import 'package:myplaces/repository/list_repository.dart';
import 'package:myplaces/repository/poi_repository.dart';
import 'package:myplaces/service/list_service.dart';
import 'package:myplaces/service/poi_search_service.dart';
import 'package:myplaces/service/poi_service.dart';
import 'package:myplaces/src/presentation/controller/common/poi/selected_poi_controller.dart';
import 'package:myplaces/src/presentation/controller/common/selected_list_controller.dart';
import 'package:myplaces/src/presentation/controller/map/map_page_controller.dart';
import 'package:myplaces/src/presentation/controller/map/map_page_state.dart';
import 'package:myplaces/src/presentation/controller/map/mysearchbar_controller.dart';

import 'models/my_list.dart';
import 'models/poi.dart';
import 'notifier/my_lists_notifier.dart';
import 'objectbox.g.dart';

final searchBarControllerProvider =
    AsyncNotifierProvider<SearchBarController, List<Poi>>(
      () => SearchBarController(),
    );
final mapPageControllerProvider =
    StateNotifierProvider<MapPageController, MapPageState>(
      (ref) => MapPageController(const MapPageState()),
    );

final selectedPoiControllerProvider =
    StateNotifierProvider<SelectedPoiController, Poi?>(
      (ref) => SelectedPoiController(null, ref.read(poiRepositoryProvider)),
    );

final selectedListControllerProvider =
    StateNotifierProvider<SelectedListController, MyList?>(
      (ref) => SelectedListController(null, ref.read(listRepositoryProvider)),
    );

final listsControllerProvider =
    AsyncNotifierProvider<SavedPageController, List<MyList>>(
      SavedPageController.new,
    );

// OLD !!!!

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
final selectedPoiProvider = StateProvider<Poi?>((ref) => null);

final myListsProvider = StateNotifierProvider<MyListsNotifier, List<MyList>>(
  (ref) => MyListsNotifier(ref.read(listRepositoryProvider)),
);

// Repository
final poiRepositoryProvider = Provider<PoiRepository>(
  (ref) => PoiRepository(
    ref.read(poiSearchServiceProvider),
    ref.read(poiServiceProvider),
  ),
);
final listRepositoryProvider = Provider<ListRepository>(
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
