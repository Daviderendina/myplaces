import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppConfig.dart';
import 'package:myplaces/features/search/providers.dart';
import 'package:myplaces/src/domain/poi.dart';

class SearchController extends AsyncNotifier<List<Poi>> {
  Timer? _debounceTimer;

  @override
  FutureOr<List<Poi>> build() {
    return [];
  }

  void onQueryChanged(String query) {
    _debounceTimer?.cancel();

    if (query.isEmpty) {
      state = const AsyncData([]);
      return;
    }

    _debounceTimer = Timer(AppConfig.debounceDuration, () async {
      state = const AsyncLoading();
      state = await AsyncValue.guard(() async {
        final service = ref.read(searchServiceProvider);
        return await service.searchPois(query);
      });
    });
  }
}
