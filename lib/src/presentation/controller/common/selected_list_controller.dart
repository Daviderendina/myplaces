import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/repository/list_repository.dart';
import 'package:myplaces/repository/poi_repository.dart';
import 'package:myplaces/src/tools/logger.dart';

import '../../../../../../models/poi.dart';
import '../../../../../models/my_list.dart';

class SelectedListController extends StateNotifier<MyList?> {
  final ListRepository repository;

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
    MyList updatedList = state!.copyWith(note: note);
    state = await repository.save(updatedList);
  }

  Future<void> deletePoiFromList(Poi poi) async {
    // TODO implementare!!!
  }
}
