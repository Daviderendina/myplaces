import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/repository/poi_repository.dart';
import 'package:myplaces/src/tools/logger.dart';

import '../../../../models/poi.dart';

class SelectedPoiController extends StateNotifier<Poi?> {
  final PoiRepository repository;

  SelectedPoiController(super._state, this.repository);

  Future<void> selectNewPoi(Poi poi) async {
    logger.info("Selecting poi: ${poi.name} / ${poi.id}");

    state = await repository.getById(poi.id) ?? poi;
    logger.info("Selected poi: ${poi.name} / ${poi.id}");
  }
}
