import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/src/application/poi_service.dart';
import 'package:myplaces/src/tools/logger.dart';

import '../../../../../../src/domain/poi.dart';
import '../../../../domain/my_list.dart';

class SelectedPoiController extends StateNotifier<Poi?> {
  final PoiService repository;

  SelectedPoiController(super._state, this.repository);

  Future<void> selectNewPoi(Poi poi) async {
    logger.info("Selecting poi: ${poi.name} / ${poi.id}");

    state = await repository.getById(poi.id) ?? poi;
    logger.info("Selected poi: ${poi.name} / ${poi.id}");
  }

  Future<void> triggerPoiToList(Poi poi, MyList myList) async {
    state = await repository.togglePoiInList(poi, myList);
  }

  bool poiBelongToList(Poi poi, MyList list) {
    return poi.lists.any((l) => l.id == list.id);
  }
}
