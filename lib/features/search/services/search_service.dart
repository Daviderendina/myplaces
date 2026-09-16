import 'package:myplaces/core/models/poi.dart';
import 'package:myplaces/features/search/repositories/search_repository.dart';

import '../model/PoiSearchResult.dart';

class SearchService {
  final SearchRepository _repository;

  SearchService(this._repository);

  Future<List<PoiSearchResult>> search(String query) async {
    if (query.isEmpty) return [];
    return await _repository.search(query);
  }

  Future<Poi> searchByIdAndType(String type, String id) async {
    if (type.trim().isEmpty || id.trim().isEmpty) {
      throw const FormatException('Type and id are required to lookup a POI');
    }

    // TODO qui quando vado a cercare un dettaglio, dovrei prima andare verso il DB locale. se non c'è, vado verso le api

    return await _repository.searchByIdAndType(type.trim(), id);
  }
}
