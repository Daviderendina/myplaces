import '../../../core/extensions/MapExtensions.dart';
import '../../../core/repository/AbstractMapper.dart';
import '../model/PoiSearchResult.dart';

class SearchMapper extends AbstractMapper<Map<String, dynamic>, List<PoiSearchResult>> {
  @override
  List<PoiSearchResult> map(Map<String, dynamic> data) {
    final properties = data['features'];
    if (properties is! List) {
      throw const FormatException('Invalid search result format');
    }

    final result = properties
        .map((rawPoi) => mapRawPoi(rawPoi))
        .whereType<PoiSearchResult>()
        .toList();
    return result;
  }

  PoiSearchResult? mapRawPoi(Map<String, dynamic> rawPoi) {
    final properties = rawPoi.getOrDefault('properties', <String, dynamic>{});
    final geocoding = properties.getOrDefault('geocoding', <String, dynamic>{});

    final name = geocoding.getOrDefault('name', '');
    final label = geocoding.getOrDefault('label', '');
    final osmType = geocoding.getOrDefault('osm_type', '');
    final id = geocoding.getOrDefault('osm_id', -1);

    if (label.isEmpty || name.isEmpty || id == -1 || osmType.isEmpty) {
      return null;
    }

    return PoiSearchResult(id.toString(), name, label, osmType: osmType);
  }
}
