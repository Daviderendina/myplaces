import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/src/presentation/controller/common/lists_controller.dart';
import 'package:myplaces/src/data/list_repository.dart';
import 'package:myplaces/src/application/poi_service.dart';
import 'package:myplaces/src/application/list_service.dart';
import 'package:myplaces/src/application/poi_search_service.dart';
import 'package:myplaces/src/data/poi_repository.dart';
import 'package:myplaces/src/presentation/controller/common/poi/selected_poi_controller.dart';
import 'package:myplaces/src/presentation/controller/common/selected_list_controller.dart';
import 'package:myplaces/src/presentation/controller/map/map_page_controller.dart';
import 'package:myplaces/src/presentation/controller/map/map_page_state.dart';
import 'package:myplaces/src/presentation/controller/map/mysearchbar_controller.dart';

import 'domain/my_list.dart';
import 'domain/poi.dart';
import '../objectbox.g.dart';

// TODO dividere nelle varie classi???

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
      (ref) => SelectedPoiController(null, ref.read(poiServiceProvider)),
    );

final selectedListControllerProvider =
    StateNotifierProvider<SelectedListController, MyList?>(
      (ref) => SelectedListController(null, ref.read(listServiceProvider)),
    );

final listsControllerProvider =
    AsyncNotifierProvider<ListsController, List<MyList>>(ListsController.new);

// Service

final poiServiceProvider = Provider<PoiService>(
  (ref) =>
      PoiService(PoiSearchService(), PoiRepository(ref.read(poiBoxProvider))),
);

final listServiceProvider = Provider<ListService>(
  (ref) => ListService(ListRepository(ref.read(myListBoxProvider))),
);

// ObjectBox

final objectBoxStoreProvider = Provider<Store>((ref) {
  throw UnimplementedError(
    "Override con lo Store reale in main() prima di runApp()",
  );
});

final myListBoxProvider = Provider<Box<MyList>>((ref) {
  final store = ref.read(objectBoxStoreProvider);
  return store.box<MyList>();
});

final poiBoxProvider = Provider<Box<Poi>>((ref) {
  final store = ref.read(objectBoxStoreProvider);
  return store.box<Poi>();
});

// TODO sistemare init
final appInitProvider = FutureProvider<void>((ref) async {
  //   // Create default lists
  //   ListRepository listService = ref.read(listServiceProvider);
  //   ref
  //       .read(configRepositoryProvider)
  //       .getDefaultLists()
  //       .where((l) => !listService.listExists(l))
  //       .map((l) => listService.save(l))
  //       .toList();
});
