import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/repository/list_repository.dart';
import 'package:myplaces/state/saved_page_state.dart';

class SavedPageNotifier extends StateNotifier<SavedPageState> {
  final ListRepository _repository;

  SavedPageNotifier(this._repository) : super(const SavedPageState());

  void getAllLists() async {
    state.copyWith(isLoading: true);

    try {
      List<MyList> allLists = _repository.getAll();
      state.copyWith(lists: allLists, isLoading: false);
    } catch (e) {
      state.copyWith(lists: [], isLoading: false); // TODO mostrare errore
    }
  }
}
