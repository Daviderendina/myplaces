import 'package:http/http.dart' as ref;
import 'package:myplaces/service/poi_service.dart';

import '../models/my_list.dart';
import '../models/poi.dart';
import '../service/poi_search_service.dart';

class PoiRepository {
  final PoiSearchService _searchService;
  final PoiService _poiService;

  PoiRepository(this._searchService, this._poiService);

  Future<List<Poi>> search(String query) {
    print("PoiRepository.search >>> Search for $query");
    return _searchService.search(query);
  }

  void save(Poi poi) async {
    print("PoiRepository.save >>> Saving Poi: ${poi.id}");
    _poiService.savePoi(poi);
  }

  // TODO fare async
  Poi? getById(String id) {
    Poi? found = _poiService.getById(id);
    print("PoiRepository.getById >>> Found poi: ${found}");
    return found;
  }

  Poi togglePoiInList(Poi poi, MyList myList) {
    if (poi.lists.any((l) => l.id == myList.id)) {
      poi.lists.removeWhere((l) => l.id == myList.id);
    } else {
      if (!poi.lists.map((l) => l.id).toSet().contains(myList.id)) {
        poi.lists.add(myList);
      }
    }
    save(poi);
    return poi;
  }
}
