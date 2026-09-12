import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../src/domain/poi.dart';
import '../../../providers.dart';
import '../../../../logger.dart';

class SearchBarController extends AsyncNotifier<List<OldPoi>> {
  @override
  FutureOr<List<OldPoi>> build() {
    return [];
  }

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = AsyncValue.data([]);
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(poiServiceProvider).search(query),
    );
    // TODO gestire error
  }
}
