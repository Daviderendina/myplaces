import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/providers.dart';

import '../../../../repository/list_repository.dart';

class MyListsController extends AsyncNotifier<List<MyList>> {
  late final ListRepository _repository;

  // TODO questo devbe tornare a gestire la lista di MyList definite - entrypoint per la gestione delle liste

  @override
  Future<List<MyList>> build() async {
    _repository = ref.read(myListRepositoryProvider);

    return _repository.getAll();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      state = AsyncData(_repository.getAll());
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addList(MyList newList) async {
    try {
      // TODO qui sarebbe carino farlo in maniera ottimistica, ma ho il problema dell'ID!!!
      MyList created = await _repository.save(newList);
      state = AsyncData([...state.requireValue, created]);
    } catch (e) {
      // print("Error adding list: $e");
    }
  }

  void deleteList(MyList myList) async {
    state = AsyncData(
      state.requireValue.where((l) => l.id != myList.id).toList(),
    );
    _repository.delete(myList);
  }
}
