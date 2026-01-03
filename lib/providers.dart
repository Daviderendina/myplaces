import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/notifier/map_page_notifier.dart';
import 'package:myplaces/repository/poi_repository.dart';
import 'package:myplaces/repository/poi_repository_impl.dart';
import 'package:myplaces/service/search_service.dart';
import 'package:myplaces/state/map_page_state.dart';

final mapPageProvider =
    StateNotifierProvider<MapPageNotifier, MapPageViewState>(
      (ref) => MapPageNotifier(ref.read(poiRepositoryProvider)),
    );

final poiServiceProvider = Provider<PoiService>((ref) => PoiService());

final poiRepositoryProvider = Provider<PoiRepository>(
  (ref) => PoiRepositoryImpl(ref.read(poiServiceProvider)),
);
