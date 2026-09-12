import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/map/controllers/main_map_controller.dart';
import 'package:myplaces/features/map/controllers/main_map_state.dart';

final mainMapControllerProvider =
    NotifierProvider<MainMapController, MainMapState>(() {
      return MainMapController();
    });
