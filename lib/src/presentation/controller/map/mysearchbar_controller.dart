import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../src/domain/poi.dart';
import '../../../providers.dart';
import '../../../../logger.dart';

class SearchBarController extends AsyncNotifier<List<Poi>> {
  @override
  FutureOr<List<Poi>> build() {
    return [];
  }

  Future<void> search(String query) async {
    logger.info("Start searching for query: $query");
    if (query.isEmpty) {
      state = AsyncValue.data([]);
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(poiServiceProvider).search(query));
    logger.info("Updated state: $state");
    // TODO gestire error
  }
}
