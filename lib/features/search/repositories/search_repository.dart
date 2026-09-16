import 'package:myplaces/core/models/poi.dart';

import '../../../core/datasource/poi/IPoiDataSource.dart';
import '../../../core/repository/AbstractMapper.dart';
import '../model/PoiSearchResult.dart';

class SearchRepository {
  final IPoiDataSource _dataSource;
  final AbstractMapper<Map<String, dynamic>, List<PoiSearchResult>> _searchMapper;
  final AbstractMapper<Map<String, dynamic>, Poi> _poiDetailsMapper;

  SearchRepository(this._dataSource, this._searchMapper, this._poiDetailsMapper);

  Future<List<PoiSearchResult>> search(String query) async {
    final rawData = await _dataSource.search(query);
    return _searchMapper.map(rawData);
  }

  Future<Poi> searchByIdAndType(String type, String id) async {
    final rawData = await _dataSource.searchByIdAndType(type, id);
    return _poiDetailsMapper.map(rawData);
  }
}
