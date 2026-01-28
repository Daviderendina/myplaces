import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/src/application/poi_service.dart';
import 'package:myplaces/src/tools/logger.dart';

import '../../../../../../src/domain/poi.dart';
import '../../../../domain/my_list.dart';

class SelectedPoiController extends StateNotifier<Poi?> {
  final PoiService _service;

  SelectedPoiController(super._state, this._service);

  Future<void> selectNewPoi(Poi poi) async {
    logger.info("Selecting poi: ${poi.name} / ${poi.id}");

    state = await _service.getById(poi.id) ?? poi;
    logger.info("Selected poi: ${poi.name} / ${poi.id}");
  }

  void triggerPoiToList(Poi poi, MyList myList) {
    Poi result = _service.togglePoiInList(poi, myList);
    // TODO non so mi sembra fragile come metodo. per ora pero funzioa
    selectNewPoi(result);
    logger.info("Toggled poi in list: ${poi.name} in list ${myList.name}");
  }

  bool poiBelongToList(Poi poi, MyList list) {
    return poi.lists.any((l) => l.id == list.id);
  }

  Future<void> updateNote(String value) async {
    state = state!.copy(note: value);
    _service.save(state!);
  }
}
