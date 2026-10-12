import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/collections/providers.dart';
import 'package:myplaces/features/poi/services/poi_service.dart';
import 'package:myplaces/features/search/providers.dart';
import 'package:myplaces/features/trips/providers.dart';

final poiServiceProvider = Provider<PoiService>((ref) {
  return PoiService(
    ref.watch(searchServiceProvider),
    ref.watch(collectionServiceProvider),
    ref.watch(tripsServiceProvider),
  );
});
