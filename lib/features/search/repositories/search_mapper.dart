import 'package:myplaces/core/models/poi/poi_category.dart';
import 'package:myplaces/core/utils/poi_category_mapping.dart';
import 'package:myplaces/logger.dart';

import '../../../core/extensions/MapExtensions.dart';
import '../../../core/models/poi/poi_address.dart';
import '../../../core/models/poi/poi_preview.dart';
import '../../../core/repository/AbstractMapper.dart';

class SearchMapper extends AbstractMapper<Map<String, dynamic>, List<PoiPreview>> {
  @override
  List<PoiPreview> map(Map<String, dynamic> data) {
    AppLogger.debug('Mapping search results from raw data: $data', SearchMapper);

    final properties = data['features'];

    if (properties is! List) {
      AppLogger.error('Invalid search result format: "features" is not a List', SearchMapper);
      throw const FormatException('Invalid search result format');
    }

    final result = properties.map((rawPoi) => mapRawPoi(rawPoi)).whereType<PoiPreview>().toList();
    return result;
  }

  PoiPreview? mapRawPoi(Map<String, dynamic> rawPoi) {
    Map<String, dynamic> properties = rawPoi.getOrDefault('properties', <String, dynamic>{})!;
    Map<String, dynamic> geocoding = properties.getOrDefault('geocoding', <String, dynamic>{})!;

    final String? name = geocoding.getOrDefault('name', null);
    final String? label = geocoding.getOrDefault('label', null);
    final String? type = geocoding.getOrDefault('osm_type', null);
    final int? id = geocoding.getOrDefault('osm_id', null);

    final String? housenumber = geocoding.getOrDefault('housenumber', null);
    final String? postcode = geocoding.getOrDefault('postcode', null);
    final String? street = geocoding.getOrDefault('street', null);
    final String? district = geocoding.getOrDefault('district', null);
    final String? city = geocoding.getOrDefault('city', null);
    final String? county = geocoding.getOrDefault('county', null);
    final String? state = geocoding.getOrDefault('state', null);
    final String? country = geocoding.getOrDefault('country', null);
    final String? countryCode = geocoding.getOrDefault('country_code', null);

    final String? osmKey = geocoding.getOrDefault('osm_key', null);
    final String? osmValue = geocoding.getOrDefault('osm_value', null);
    final PoiCategory category = mapPoiCategory(osmKey, osmValue);

    if (label == null || name == null || id == null || type == null) {
      AppLogger.error(
        'Invalid search result format - label=$label name=$name id=$id type=$type',
        SearchMapper,
      );
      return null;
    }

    AppLogger.debug('Successfully mapped POI: id=$id, name=$name', SearchMapper);

    return PoiPreview(
      id: id.toString(),
      name: name,
      address: PoiAddress(
        houseNumber: housenumber,
        postcode: postcode,
        street: street,
        district: district,
        city: city,
        county: county,
        state: state,
        country: country,
        countryCode: countryCode?.toUpperCase(),
      ),
      type: type,
      category: category,
    );
  }
}
