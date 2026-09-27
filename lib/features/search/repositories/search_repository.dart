import 'package:myplaces/core/models/poi.dart';

import '../../../core/datasource/poi/IPoiDataSource.dart';
import '../../../core/repository/AbstractMapper.dart';
import '../model/PoiPreview.dart';

class SearchRepository {
  final IPoiDataSource _dataSource;
  final AbstractMapper<Map<String, dynamic>, List<PoiPreview>> _searchMapper;
  final AbstractMapper<Map<String, dynamic>, Poi> _poiDetailsMapper;

  SearchRepository(this._dataSource, this._searchMapper, this._poiDetailsMapper);

  Future<List<PoiPreview>> search(String query) async {
    final rawData = await _dataSource.search(query);
    return _searchMapper.map(rawData);
  }

  Future<Poi> searchByIdAndType(String type, String id) async {
    final rawData = await _dataSource.searchByIdAndType(type, id);
    return _poiDetailsMapper.map(rawData);
  }
}
