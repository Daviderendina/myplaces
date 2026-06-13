import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/src/presentation/controller/common/lists_controller.dart';
import 'package:myplaces/src/application/list_service.dart';
import 'package:myplaces/src/application/poi_service.dart';
import 'package:myplaces/src/data/list_repository.dart';
import 'package:myplaces/src/application/poi_search_service.dart';
import 'package:myplaces/src/data/poi_repository.dart';
import 'package:myplaces/src/presentation/controller/common/poi/selected_poi_controller.dart';
import 'package:myplaces/src/presentation/controller/common/selected_list_controller.dart';
import 'package:myplaces/src/presentation/controller/map/map_page_controller.dart';
import 'package:myplaces/src/presentation/controller/map/map_page_state.dart';
import 'package:myplaces/src/presentation/controller/map/mysearchbar_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'application/settings_service.dart';
import 'domain/my_list.dart';
import 'domain/poi.dart';

final searchBarControllerProvider = AsyncNotifierProvider<SearchBarController, List<Poi>>(
  () => SearchBarController(),
);
final mapPageControllerProvider = StateNotifierProvider<MapPageController, MapPageState>(
  (ref) => MapPageController(const MapPageState()),
);

final selectedPoiControllerProvider = StateNotifierProvider<SelectedPoiController, Poi?>(
  (ref) => SelectedPoiController(null, ref.read(poiServiceProvider)),
);

final selectedListControllerProvider = StateNotifierProvider<SelectedListController, MyList?>(
  (ref) => SelectedListController(
    null,
    ref.read(listServiceProvider),
    ref.read(listsControllerProvider.notifier),
  ),
);

final listsControllerProvider = AsyncNotifierProvider<ListsController, List<MyList>>(
  ListsController.new,
);

// Service

final poiServiceProvider = Provider<PoiService>(
  (ref) => PoiService(PoiSearchService(), PoiRepository()),
);

final listServiceProvider = Provider<ListService>((ref) => ListService(ListRepository()));

final settingsServiceProvider = FutureProvider<SettingsService>((ref) async {
  final prefs = await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(),
  );
  return SettingsService(prefs);
});

// appInit
final appInitProvider = FutureProvider<void>((ref) async {
  // logic removed as requested
});
