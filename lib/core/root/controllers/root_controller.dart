import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'root_state.dart';

class RootController extends Notifier<RootState> {
  @override
  RootState build() {
    return RootState(selectedIndex: 0);
  }

  Future<void> changePage(int index) async {
    state = state.copyWith(selectedIndex: index);
  }
}
