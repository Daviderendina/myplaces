import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/collection.dart';
import '../providers.dart';
import '../services/collections_service.dart';
import 'collections_state.dart';

class CollectionsController extends AsyncNotifier<CollectionsState> {
  late final CollectionService _service;

  @override
  Future<CollectionsState> build() async {
    _service = ref.read(collectionsServiceProvider);

    final initial = await _service.fetchAll();

    ref.listen(collectionsStreamProvider, (_, next) {
      next.whenData((list) {
        state = AsyncData(
          state.value!.copyWith(allCollections: list, displayedCollections: list),
        ); // TODO qui devo modificare la active query anche?
      });
    });

    return CollectionsState(allCollections: initial, displayedCollections: initial);
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
}
