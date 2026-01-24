import 'package:myplaces/src/data/poi_repository.dart';

import '../domain/my_list.dart';
import '../domain/poi.dart';
import '../tools/logger.dart';
import 'poi_search_service.dart';

class PoiService {
  final PoiSearchService _searchService;
  final PoiRepository _poiRepository;

  PoiService(this._searchService, this._poiRepository);

  Future<List<Poi>> search(String query) {
    logger.info("Searching for query: $query");
    return _searchService.search(query);
  }

  Future<Poi> save(Poi poi) async {
    Poi? poiSaved = await _poiRepository.getById(poi.id);

    if (poiSaved != null) {
      poi.obxId = poiSaved.obxId;
    }

    return _poiRepository.savePoi(poi);
    // TODO forse devo tornare copy per forzare aggiornamento???
  }

  Future<Poi?> getById(String id) async {
    return _poiRepository.getById(id);
  }

  Future<Poi> togglePoiInList(Poi poi, MyList myList) async {
    bool listBelongToPoi = poi.lists.any((l) => l.id == myList.id);
    if (listBelongToPoi) {
      poi.lists.removeWhere((l) => l.id == myList.id);
    } else {
      poi.lists.add(myList);
    }

    return await save(poi);
  }
}
