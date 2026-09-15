import 'package:myplaces/shared/datasource/poi/IPoiDataSource.dart';
import 'package:myplaces/shared/repository/AbstractMapper.dart';

import '../model/PoiSearchResult.dart';

class SearchRepository {
  final IPoiDataSource _dataSource;
  final AbstractMapper _searchMapper;

  SearchRepository(this._dataSource, this._searchMapper);

  Future<List<PoiSearchResult>> search(String query) async {
    final rawData = await _dataSource.search(query);
    return Future.value(_searchMapper.map(rawData));
  }
}
