import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppConfig.dart';
import 'package:myplaces/features/search/providers.dart';

import '../model/PoiSearchResult.dart';

class SearchController extends AsyncNotifier<List<PoiSearchResult>> {
  Timer? _debounceTimer;

  @override
  FutureOr<List<PoiSearchResult>> build() {
    return [];
  }

  void onQueryChanged(String query) {
    _debounceTimer?.cancel();

    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      state = const AsyncData([]);
      return;
    }

    // Impostiamo immediatamente lo stato a loading (o manteniamo il precedente)
    // per segnalare alla UI che una ricerca è "in arrivo"
    if (!state.isLoading) {
      state = const AsyncValue.loading();
    }

    _debounceTimer = Timer(AppConfig.debounceDuration, () async {
      state = await AsyncValue.guard(() async {
        final service = ref.read(searchServiceProvider);
        return await service.searchPois(trimmedQuery);
      });
    });
  }

  void clearResults() {
    _debounceTimer?.cancel();
    state = const AsyncData([]);
  }
}
