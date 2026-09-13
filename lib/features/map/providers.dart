import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/collections/providers.dart';
import 'package:myplaces/features/collections/services/collections_service.dart';
import 'package:myplaces/features/map/controllers/main_map_controller.dart';
import 'package:myplaces/features/map/controllers/main_map_state.dart';

final mainMapCollectionsServiceProvider = Provider<CollectionService>((ref) {
  return ref.watch(collectionsServiceProvider);
});

final mainMapControllerProvider =
    AsyncNotifierProvider<MainMapController, MainMapState>(MainMapController.new);
