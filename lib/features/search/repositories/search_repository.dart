import 'dart:math';

import 'package:latlong2/latlong.dart';
import 'package:myplaces/features/search/datasources/search_datasource.dart';

import '../../../core/models/poi.dart';

class SearchRepository {
  final SearchDataSource _dataSource;

  SearchRepository(this._dataSource);

  Future<List<Poi>> searchPois(String query) async {
    // final rawData = await _dataSource.searchPois(query);
    return [
      Poi(
        id: "1",
        name: 'Pizzeria da Mario',
        coordinates: LatLng(12.4539, 41.9065),
      ),
    ];
  }
}
