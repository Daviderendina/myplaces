import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/collection.dart';
import '../providers.dart';
import 'collections_state.dart';

class CollectionsController extends AsyncNotifier<CollectionsState> {
  @override
  Future<CollectionsState> build() async {
    final service = ref.watch(collectionsServiceProvider);
    final collections = await service.getCollections();

    return CollectionsState(allCollections: collections, displayedCollections: collections);
  }

  void filter(String query) {
    final currentState = state.value;
    if (currentState == null) return;

    if (query.isEmpty) {
      state = AsyncData(currentState.copyWith(displayedCollections: currentState.allCollections));
    } else {
      final filteredList = currentState.allCollections
          .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      state = AsyncData(currentState.copyWith(displayedCollections: filteredList));
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(collectionsServiceProvider);
      final collections = await service.getCollections();
      return CollectionsState(allCollections: collections, displayedCollections: collections);
    });
  }

  Future<bool> addCollection(String name) async {
    final service = ref.read(collectionsServiceProvider);
    final success = await service.saveCollection(name);

    if (success) {
      // Se il salvataggio ha successo, ricarichiamo la lista
      await refresh();
    }

    return true; //false && success;
  }
}
