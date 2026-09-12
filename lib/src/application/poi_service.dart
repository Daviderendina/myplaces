import 'package:myplaces/src/data/poi_repository.dart';

import '../domain/my_list.dart';
import '../domain/poi.dart';
import '../../logger.dart';
import 'poi_search_service.dart';

class PoiService {
  final PoiSearchService _searchService;
  final PoiRepository _poiRepository;

  PoiService(this._searchService, this._poiRepository);

  Future<List<OldPoi>> search(String query) {
    return _searchService.search(query);
  }

  Future<OldPoi> save(OldPoi poi) async {
    OldPoi? poiSaved = await _poiRepository.getById(poi.id);

    if (poiSaved != null) {
      poi.obxId = poiSaved.obxId;
    }

    return _poiRepository.savePoi(poi);
    // TODO forse devo tornare copy per forzare aggiornamento???
  }

  Future<OldPoi?> getById(String id) async {
    return _poiRepository.getById(id);
  }

  OldPoi togglePoiInList(OldPoi poi, MyList myList) {
    bool listBelongToPoi = poi.lists.any((l) => l.id == myList.id);
    if (listBelongToPoi) {
      poi.lists.removeWhere((l) => l.id == myList.id);
    } else {
      poi.lists.add(myList);
    }

    save(poi);
    return poi;
  }
}
