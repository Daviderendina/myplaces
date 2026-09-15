import 'package:myplaces/shared/repository/AbstractMapper.dart';

import '../../../shared/extensions/MapExtensions.dart';
import '../model/PoiSearchResult.dart';

class SearchMapper extends AbstractMapper<Map<String, dynamic>, List<PoiSearchResult>> {
  @override
  List<PoiSearchResult> map(Map<String, dynamic> data) {
    final properties = data['features'];
    if (properties is! List) {
      throw const FormatException('Invalid search result format');
    }

    // TODO
    if (properties.isEmpty) {
      throw const FormatException('No search results found');
    }

    List<PoiSearchResult?> result = properties.map((rawPoi) => mapRawPoi(rawPoi)).toList();
    result.removeWhere((element) => element == null);
    return result.cast<PoiSearchResult>();
  }

  PoiSearchResult? mapRawPoi(Map<String, dynamic> rawPoi) {
    Map<String, dynamic> properties = rawPoi.getOrDefault('properties', {});
    Map<String, dynamic> geocoding = properties.getOrDefault('geocoding', {});

    final name = geocoding.getOrDefault('name', '');
    final label = geocoding.getOrDefault('label', '');
    final placeId = geocoding.getOrDefault('place_id', -1);

    if (label.isEmpty || placeId == -1 || name.isEmpty) {
      return null;
    }

    return PoiSearchResult(placeId.toString(), name, label);
  }
}
