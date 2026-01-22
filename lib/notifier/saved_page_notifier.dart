import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/providers.dart';

import '../repository/list_repository.dart';

class SavedPageController extends AsyncNotifier<List<MyList>> {
  late final ListRepository _repository;

  @override
  Future<List<MyList>> build() async {
    _repository = ref.read(listRepositoryProvider);

    return _repository.getAll();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final lists = _repository.getAll();
      state = AsyncData(lists);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addList(MyList newList) async {
    final current = state.value ?? [];

    try {
      MyList created = await _repository.save(newList);
      state = AsyncData([...current, created]);
    } catch (e) {
      // print("Error adding list: $e");
    }
  }

  void removeList(MyList myList) async {
    _repository.delete(myList);
  }
}
