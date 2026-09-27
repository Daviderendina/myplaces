import 'package:myplaces/core/utils/poi_category_mapping.dart';

import '../../../core/extensions/MapExtensions.dart';
import '../../../core/models/poi/poi_address.dart';
import '../../../core/models/poi/poi_preview.dart';
import '../../../core/repository/AbstractMapper.dart';

class SearchMapper extends AbstractMapper<Map<String, dynamic>, List<PoiPreview>> {
  @override
  List<PoiPreview> map(Map<String, dynamic> data) {
    final properties = data['features'];
    if (properties is! List) {
      throw const FormatException('Invalid search result format');
    }

    final result = properties.map((rawPoi) => mapRawPoi(rawPoi)).whereType<PoiPreview>().toList();
    return result;
  }

  PoiPreview? mapRawPoi(Map<String, dynamic> rawPoi) {
    final properties = rawPoi.getOrDefault('properties', <String, dynamic>{});
    final geocoding = properties.getOrDefault('geocoding', <String, dynamic>{});

    final name = geocoding.getOrDefault('name', '');
    final label = geocoding.getOrDefault('label', '');
    final type = geocoding.getOrDefault('osm_type', '');
    final id = geocoding.getOrDefault('osm_id', -1);

    final osmKey = geocoding.getOrDefault('osm_key', '');
    final osmValue = geocoding.getOrDefault('osm_value', '');
    final category = mapPoiCategory(osmKey, osmValue);

    if (label.isEmpty || name.isEmpty || id == -1 || type.isEmpty) {
      return null;
    }

    return PoiPreview(
      id: id.toString(),
      name: name,
      address: PoiAddress(text: label),
      type: type,
      category: category,
      photoQuery: name,
    );
  }
}
