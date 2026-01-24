import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/src/data/list_repository.dart';

import '../../../../../../src/domain/poi.dart';
import '../../../domain/my_list.dart';
import '../../../tools/logger.dart';

class SelectedListController extends StateNotifier<MyList?> {
  final ListService repository;

  SelectedListController(super._state, this.repository);

  Future<void> selectNewList(MyList myList) async {
    state = repository.getById(myList.id) ?? myList;
  }

  Future<void> setListVisibility(bool value) async {
    MyList updatedList = state!.copyWith(isArchived: value);
    state = await repository.save(updatedList);

    // if (updatedList != null) {
    //   state = updatedList;
    //   repository.save(updatedList);
    // }
  }

  Future<void> updateNote(String note) async {
    logger.info("Updating note: $note");
    MyList updatedList = state!.copyWith(note: note);
    state = await repository.save(updatedList);
    logger.info("Saved note, new state: $state");
  }

  Future<void> deletePoiFromList(Poi poi) async {
    // TODO implementare!!!
  }
}
