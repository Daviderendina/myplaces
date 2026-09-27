import 'package:latlong2/latlong.dart';

import '../../../core/extensions/MapExtensions.dart';
import '../../../core/models/poi.dart';
import '../../../core/models/poi/poi_address.dart';
import '../../../core/repository/AbstractMapper.dart';
import '../../../core/utils/poi_category_mapping.dart';

class PoiDetailsMapper extends AbstractMapper<Map<String, dynamic>, Poi> {
  @override
  Poi map(Map<String, dynamic> data) {
    final osmIdRaw = data.getOrDefault('osm_id', -1);
    final osmId = osmIdRaw is num ? osmIdRaw.toInt() : -1;
    final name = _resolveName(data);

    final osmKey = data.getOrDefault('osm_key', '');
    final osmValue = data.getOrDefault('osm_value', '');
    final category = mapPoiCategory(osmKey, osmValue); // TODO non mi piace farlo in giro così

    final type = data.getOrDefault('osm_type', '');

    if (osmId == -1 || name.isEmpty) {
      throw const FormatException('Invalid POI detail format');
    }

    return Poi(
      id: osmId.toString(),
      name: name,
      coordinates: _resolveCoordinates(data),
      type: type,
      category: category,
      address: const PoiAddress(text: 'Address details not available yet'),
    );
  }

  String _resolveName(Map<String, dynamic> rawPoi) {
    final names = rawPoi.getOrDefault('names', <String, dynamic>{});
    final localizedNames = names.cast<String, dynamic>();
    for (final key in ['name:it', 'name:en', 'name']) {
      final value = localizedNames[key];
      if (value is String && value.trim().isNotEmpty) {
        return value;
      }
    }

    final localName = rawPoi.getOrDefault('localname', '');
    if (localName.trim().isNotEmpty) {
      return localName;
    }

    final displayName = rawPoi.getOrDefault('display_name', '');
    if (displayName.trim().isNotEmpty) {
      return displayName;
    }

    return '';
  }

  LatLng _resolveCoordinates(Map<String, dynamic> rawPoi) {
    final geometry = rawPoi.getOrDefault('geometry', <String, dynamic>{});
    final coordinates = geometry.getOrDefault('coordinates', <dynamic>[]);
    if (coordinates.length >= 2) {
      final longitude = _asDouble(coordinates[0]);
      final latitude = _asDouble(coordinates[1]);
      return LatLng(latitude, longitude);
    }

    final centroid = rawPoi.getOrDefault('centroid', <String, dynamic>{});
    if (centroid is Map) {
      final coordinates = centroid.getOrDefault('coordinates', <dynamic>[]);
      if (coordinates is List && coordinates.length >= 2) {
        final longitude = _asDouble(coordinates[0]);
        final latitude = _asDouble(coordinates[1]);
        return LatLng(latitude, longitude);
      }
    }

    return const LatLng(0, 0);
  }

  double _asDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }
    return 0.0;
  }
}
