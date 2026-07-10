import 'package:myplaces/features/search/datasources/search_datasource.dart';
import 'package:myplaces/src/domain/poi.dart';

class SearchRepository {
  final SearchDataSource _dataSource;

  SearchRepository(this._dataSource);

  Future<List<Poi>> searchPois(String query) async {
    final rawData = await _dataSource.searchPois(query);
    return rawData.map((json) => Poi.fromJson(json)).toList();
  }
}
