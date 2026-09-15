import 'package:myplaces/features/search/repositories/search_repository.dart';

import '../model/PoiSearchResult.dart';

class SearchService {
  final SearchRepository _repository;

  SearchService(this._repository);

  Future<List<PoiSearchResult>> searchPois(String query) async {
    if (query.isEmpty) return [];
    // Here we could add business logic if needed
    return await _repository.search(query);
  }
}
