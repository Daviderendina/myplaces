import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/domain/my_list.dart';
import 'package:myplaces/src/providers.dart';

import '../../../data/list_repository.dart';

class ListsController extends AsyncNotifier<List<MyList>> {
  late final ListService _repository;

  @override
  Future<List<MyList>> build() async {
    _repository = ref.read(listServiceProvider);

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

  void updateList(MyList myList) {
    // TODO non mi piace troppo questo metodo
    state = const AsyncLoading();
    int index = state.requireValue.indexWhere((l) => l.id == myList.id);

    if (index != -1) {
      // crea una copia della lista per aggiornare lo stato in modo sicuro
      final newList = List<MyList>.from(state.requireValue);
      newList[index] = myList;
      state = AsyncData(newList);

      _repository.save(myList);
    }
  }
}
