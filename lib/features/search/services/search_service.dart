import 'package:myplaces/core/models/poi.dart';
import 'package:myplaces/features/search/repositories/search_repository.dart';

class SearchService {
  final SearchRepository _repository;

  SearchService(this._repository);

  Future<List<Poi>> searchPois(String query) async {
    if (query.isEmpty) return [];
    // Here we could add business logic if needed
    return await _repository.searchPois(query);
  }
}
