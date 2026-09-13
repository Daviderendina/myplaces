import 'package:flutter_test/flutter_test.dart';
import 'package:myplaces/features/collections/repositories/collection_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CollectionRepository', () {
    test('setVisibleCollections updates visibility and emits the new cache', () async {
      final repo = CollectionRepository();
      addTearDown(repo.dispose);

      final initialCollections = await repo.fetchAll();
      final selectedIds = initialCollections.take(2).map((collection) => collection.id).toSet();

      final updateFuture = repo.watchCollections().asBroadcastStream().first;

      await repo.setVisibleCollections(selectedIds);

      final updatedCollections = await updateFuture;
      final selectedVisible = updatedCollections
          .where((collection) => selectedIds.contains(collection.id))
          .every((collection) => collection.visibleOnMap);
      final unselectedHidden = updatedCollections
          .where((collection) => !selectedIds.contains(collection.id))
          .every((collection) => !collection.visibleOnMap);

      expect(updatedCollections.length, initialCollections.length);
      expect(selectedVisible, isTrue);
      expect(unselectedHidden, isTrue);
    });
  });
}
