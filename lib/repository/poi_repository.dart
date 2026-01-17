import 'package:myplaces/service/poi_service.dart';

import '../models/my_list.dart';
import '../models/poi.dart';
import '../service/poi_search_service.dart';

class PoiRepository {
  final PoiSearchService _searchService;
  final PoiService _poiService;

  PoiRepository(this._searchService, this._poiService);

  Future<List<Poi>> search(String query) {
    // print("PoiRepository.search >>> Search for $query");
    return _searchService.search(query);
  }

  Future<Poi> save(Poi poi) async {
    // print("PoiRepository.save >>> Saving Poi: ${poi.id}");
    return _poiService.savePoi(poi);
  }

  // TODO fare async
  Future<Poi?> getById(String id) async {
    Poi? found = _poiService.getById(id);
    // print("PoiRepository.getById >>> Found poi: ${found}");
    return found;
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
