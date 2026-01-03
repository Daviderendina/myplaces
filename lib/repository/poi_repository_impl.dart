import 'package:myplaces/repository/poi_repository.dart';

import '../models/poi.dart';
import '../service/search_service.dart';

class PoiRepositoryImpl implements PoiRepository {
  final PoiService service;

  PoiRepositoryImpl(this.service);

  @override
  Future<List<Poi>> search(String query) {
    print("Search for $query");
    return service.search(query);
  }
}
