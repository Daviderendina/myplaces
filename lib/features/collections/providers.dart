import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controllers/collections_controller.dart';
import 'controllers/collections_state.dart';
import 'services/collections_service.dart';

final collectionsServiceProvider = Provider<CollectionsService>((ref) {
  return CollectionsService();
});

final collectionsControllerProvider =
    AsyncNotifierProvider<CollectionsController, CollectionsState>(() {
      return CollectionsController();
    });
