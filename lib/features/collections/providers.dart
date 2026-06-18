import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/collections/repositories/collection_repository.dart';
import 'controllers/add_collection_controller.dart';
import 'controllers/add_collection_state.dart';
import 'controllers/collections_controller.dart';
import 'controllers/collections_state.dart';
import 'models/collection.dart';
import 'services/collections_service.dart';

// Collections
final collectionRepositoryProvider = Provider<CollectionRepository>((ref) {
  //final client = ref.read(collectionClientProvider);
  final repo = CollectionRepository();
  ref.onDispose(() => repo.dispose()); // chiude lo StreamController
  return repo;
});

final collectionsServiceProvider = Provider<CollectionService>((ref) {
  return CollectionService(ref.read(collectionRepositoryProvider));
});

final collectionsControllerProvider =
    AsyncNotifierProvider<CollectionsController, CollectionsState>(CollectionsController.new);

// Add Collection
final addCollectionControllerProvider =
    NotifierProvider.autoDispose<AddCollectionController, AddCollectionState>(
      AddCollectionController.new,
    );

// Stream Provider: provide the stream of collections
final collectionsStreamProvider = StreamProvider<List<Collection>>((ref) {
  return ref.read(collectionsServiceProvider).watchCollections();
});
