import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/poi.dart';
import '../../../providers.dart';

class SearchBarController extends AsyncNotifier<List<Poi>> {
  @override
  FutureOr<List<Poi>> build() {
    return [];
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = AsyncValue.data([]);
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(poiRepositoryProvider).search(query),
    );
    // TODO gestire error
  }
}
