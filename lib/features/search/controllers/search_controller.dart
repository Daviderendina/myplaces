import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppConfig.dart';
import 'package:myplaces/features/search/providers.dart';
import 'package:myplaces/logger.dart';

import '../../../core/models/poi/poi_preview.dart';

class SearchController extends AsyncNotifier<List<PoiPreview>> {
  Timer? _debounceTimer;

  @override
  FutureOr<List<PoiPreview>> build() {
    return [];
  }

  void onQueryChanged(String query) {
    AppLogger.debug('Query changed: "$query"', SearchController);
    _debounceTimer?.cancel();

    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      AppLogger.debug('Query is empty, clearing results', SearchController);
      state = const AsyncData([]);
      return;
    }

    if (!state.isLoading) {
      AppLogger.debug('Setting state to loading', SearchController);
      state = const AsyncValue.loading();
    }

    _debounceTimer = Timer(AppConfig.debounceDuration, () async {
      AppLogger.info('Executing search for query: "$trimmedQuery"', SearchController);
      try {
        final service = ref.read(searchServiceProvider);
        final results = await service.search(trimmedQuery);
        AppLogger.info(
          'Search returned ${results.length} results for "$trimmedQuery"',
          SearchController,
        );
        state = AsyncData(results);
      } catch (e, st) {
        AppLogger.error(
          'Search failed for query "$trimmedQuery"',
          SearchController,
          error: e,
          stackTrace: st,
        );
        state = AsyncError(e, st);
      }
    });
  }

  void clearResults() {
    AppLogger.debug('Clearing search results', SearchController);
    _debounceTimer?.cancel();
    state = const AsyncData([]);
  }
}
