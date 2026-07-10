import 'package:myplaces/features/search/repositories/search_repository.dart';
import 'package:myplaces/src/domain/poi.dart';

class SearchService {
  final SearchRepository _repository;

  SearchService(this._repository);

  Future<List<Poi>> searchPois(String query) async {
    if (query.isEmpty) return [];
    // Here we could add business logic if needed
    return await _repository.searchPois(query);
  }
}
