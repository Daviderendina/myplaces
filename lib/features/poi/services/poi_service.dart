import 'package:myplaces/core/models/poi.dart';
import 'package:myplaces/core/models/poi/poi_preview.dart';
import 'package:myplaces/features/collections/models/collection.dart';
import 'package:myplaces/features/collections/services/collections_service.dart';
import 'package:myplaces/features/search/services/search_service.dart';
import 'package:myplaces/features/trips/models/trip.dart';
import 'package:myplaces/features/trips/services/trips_service.dart';

class PoiService {
  final SearchService _searchService;
  final CollectionsService _collectionsService;
  final TripsService _tripsService;

  PoiService(this._searchService, this._collectionsService, this._tripsService);

  Future<Poi> getPoiDetail(PoiPreview poiPreview) async {
    final results = await Future.wait([
      _searchService.getPoiDetailFromPreview(poiPreview),
      _collectionsService.getCollectionByPoi(poiPreview),
      _tripsService.getTripsByPoi(poiPreview),
    ], eagerError: false);

    final poi = results[0] as Poi;
    final collectionsBelonged = results[1] as List<Collection>;
    final tripsBelonged = results[2] as List<Trip>;

    return poi.copyWith(collectionsBelonged: collectionsBelonged, tripsBelonged: tripsBelonged);
  }
}
