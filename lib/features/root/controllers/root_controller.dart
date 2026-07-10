import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/map/providers.dart';
import 'root_state.dart';

class RootController extends Notifier<RootState> {
  @override
  RootState build() {
    return RootState(selectedIndex: 0);
  }

  Future<void> setIndex(int index) async {
    state = state.copyWith(selectedIndex: index);

    // Reset map selection when switching tabs
    ref.read(mapSelectionProvider.notifier).clear();
  }
}
