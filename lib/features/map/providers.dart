import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/map/controllers/map_selection_controller.dart';
import 'package:myplaces/src/domain/poi.dart';

final mapSelectionProvider = NotifierProvider<MapSelectionController, Poi?>(() {
  return MapSelectionController();
});
