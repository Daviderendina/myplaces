import 'package:latlong2/latlong.dart';
import 'package:myplaces/core/models/poi/poi_category.dart';
import 'package:myplaces/logger.dart';

import '../../../core/extensions/MapExtensions.dart';
import '../../../core/models/poi.dart';
import '../../../core/repository/AbstractMapper.dart';
import '../../../core/utils/poi_category_mapping.dart';

class PoiDetailsMapper extends AbstractMapper<Map<String, dynamic>, Poi> {
  @override
  Poi map(Map<String, dynamic> data) {
    AppLogger.debug('Mapping POI detail from raw data: $data', PoiDetailsMapper);
    int? osmId = data.getOrDefault('osm_id', null);
    final name = _resolveName(data);

    final String? osmKey = data.getOrDefault('osm_key', null);
    final String? osmValue = data.getOrDefault('osm_value', null);
    final PoiCategory category = mapPoiCategory(
      osmKey,
      osmValue,
    ); // TODO non mi piace farlo in giro così
    final String? type = data.getOrDefault('osm_type', null);

    if (osmId == null || name == null || type == null) {
      AppLogger.error('Missing required fields: id=$osmId name=$name type=$type', PoiDetailsMapper);
      throw const FormatException('Invalid POI detail format');
    }

    AppLogger.debug('Successfully mapped POI detail: id=$osmId, name=$name', PoiDetailsMapper);
    return Poi(
      id: osmId.toString(),
      name: name,
      coordinates: _resolveCoordinates(data),
      type: type,
      category: category,
    );
  }

  String? _resolveName(Map<String, dynamic> rawPoi) {
    AppLogger.debug('Resolving POI name', PoiDetailsMapper);
    final names = rawPoi.getOrDefault('names', <String, dynamic>{})!;
    final localizedNames = names.cast<String, dynamic>();
    for (final key in ['name:it', 'name:en', 'name']) {
      final value = localizedNames[key];
      if (value is String && value.trim().isNotEmpty) {
        AppLogger.debug('Resolved localized name via "$key": "$value"', PoiDetailsMapper);
        return value;
      }
    }

    final localName = rawPoi.getOrDefault('localname', null);
    if (localName is String && localName.trim().isNotEmpty) {
      AppLogger.debug('Resolved name via "localname": "$localName"', PoiDetailsMapper);
      return localName;
    }

    final displayName = rawPoi.getOrDefault('display_name', null);
    if (displayName is String && displayName.trim().isNotEmpty) {
      AppLogger.debug('Resolved name via "display_name": "$displayName"', PoiDetailsMapper);
      return displayName;
    }

    AppLogger.warn('Could not resolve POI name from raw data', PoiDetailsMapper);
    return null;
  }

  LatLng _resolveCoordinates(Map<String, dynamic> rawPoi) {
    AppLogger.debug('Resolving POI coordinates', PoiDetailsMapper);
    final geometry = rawPoi.getOrDefault('geometry', <String, dynamic>{})!;
    final coordinates = geometry.getOrDefault('coordinates', <dynamic>[])!;
    if (coordinates.length >= 2) {
      final longitude = _asDouble(coordinates[0]);
      final latitude = _asDouble(coordinates[1]);
      AppLogger.debug(
        'Resolved coordinates from geometry: ($latitude, $longitude)',
        PoiDetailsMapper,
      );
      return LatLng(latitude, longitude);
    }

    final centroid = rawPoi.getOrDefault('centroid', null);
    if (centroid is Map) {
      final coordinates = centroid.getOrDefault('coordinates', null);
      if (coordinates is List && coordinates.length >= 2) {
        final longitude = _asDouble(coordinates[0]);
        final latitude = _asDouble(coordinates[1]);
        AppLogger.debug(
          'Resolved coordinates from centroid: ($latitude, $longitude)',
          PoiDetailsMapper,
        );
        return LatLng(latitude, longitude);
      }
    }

    AppLogger.warn('Could not resolve coordinates, falling back to (0, 0)', PoiDetailsMapper);
    return const LatLng(0, 0);
  }

  double _asDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    return 0.0;
  }
}
