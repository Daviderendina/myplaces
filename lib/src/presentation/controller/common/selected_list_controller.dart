import 'dart:math';

import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/src/application/list_service.dart';
import 'package:myplaces/src/providers.dart';

import '../../../../../../src/domain/poi.dart';
import '../../../domain/my_list.dart';
import 'lists_controller.dart';

class SelectedListController extends StateNotifier<MyList?> {
  // TODO questo modo di gestire le modifiche forse va applicato anche agli altri casi????
  // TODO le modifiche qui devono avere effetto anche sul provider princiaple!! oppure fare un provider unico
  final ListService repository;
  final ListsController allListsController;

  SelectedListController(super._state, this.repository, this.allListsController);

  Future<void> selectNewList(MyList myList) async {
    MyList? fromRepository = await repository.getById(myList.id);

    if (fromRepository == null) {
      state = myList;
    } else {
      state = fromRepository;
    }
  }

  Future<void> updateNote(String note) async {
    state!.note = note;
    await repository.save(state!);
    state = await repository.getById(state!.id);

    allListsController.refresh();
  }

  Future<void> deletePoiFromList(Poi poi) async {
    // final updatedList = state!.copyWith();
    // updatedList.poiList.removeWhere((p) => p.id == poi.id);

    state!.poiList.removeWhere((p) => p.id == poi.id);
    await repository.save(state!);

    // repository.save(updatedList);
    // TODO non devo aggiornare altri - quello delle liste intendo??? Sicuramente ho un places in meno quindi si

    state = await repository.getById(state!.id);

    allListsController.refresh();
  }

  Future<void> updateList({
    String? newEmoji,
    bool? isHidden,
    bool? visibleOnMap,
    String? name,
  }) async {
    if (newEmoji != null) state!.emoji = newEmoji;
    if (isHidden != null) state!.isArchived = isHidden;
    if (visibleOnMap != null) state!.visibleOnMap = visibleOnMap;
    if (name != null) state!.name = name.toLowerCase();

    await repository.save(state!);
    state = state!;

    allListsController.refresh();
  }
}
