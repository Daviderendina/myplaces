import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/notifier/map_page_notifier.dart';
import 'package:myplaces/notifier/saved_page_notifier.dart';
import 'package:myplaces/repository/list_repository.dart';
import 'package:myplaces/repository/poi_repository.dart';
import 'package:myplaces/repository/poi_repository_impl.dart';
import 'package:myplaces/service/list_service.dart';
import 'package:myplaces/service/search_service.dart';
import 'package:myplaces/state/map_page_state.dart';
import 'package:myplaces/state/saved_page_state.dart';

import 'models/my_list.dart';
import 'objectbox.g.dart';

final appInitProvider = FutureProvider<void>((ref) async {
  // Create default lists
  // TODO fare una config da qualche parte
  final lists = ['Wishlist', 'Favourites', 'Visited'];
  for (var e in lists) {
    ref.read(listServiceProvider).addList(MyList(name: e, isDefault: true));
  }
});

final mapPageProvider =
    StateNotifierProvider<MapPageNotifier, MapPageViewState>(
      (ref) => MapPageNotifier(ref.read(poiRepositoryProvider)),
    );
final savedPageProvider =
    StateNotifierProvider<SavedPageNotifier, SavedPageState>(
      (ref) => SavedPageNotifier(ref.read(myListRepositoryProvider)),
    );

final poiRepositoryProvider = Provider<PoiRepository>(
  (ref) => PoiRepositoryImpl(ref.read(poiServiceProvider)),
);
final myListRepositoryProvider = Provider<ListRepository>(
  (ref) => ListRepository(ref.read(listServiceProvider)),
);

final listServiceProvider = Provider<ListService>(
  (ref) => ListService(ref.read(myListBoxProvider)),
);
final poiServiceProvider = Provider<PoiService>((ref) => PoiService());

final myListBoxProvider = Provider<Box<MyList>>((ref) {
  final store = ref.read(objectBoxStoreProvider);
  return store.box<MyList>();
});

final objectBoxStoreProvider = Provider<Store>((ref) {
  throw UnimplementedError(
    "Override con lo Store reale in main() prima di runApp()",
  );
});
