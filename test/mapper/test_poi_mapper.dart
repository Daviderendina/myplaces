import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:myplaces/mapper/poi_mapper.dart';
import 'package:myplaces/models/poi.dart';
import 'package:myplaces/models/poi_category.dart';

void main() {
  group('PoiMapper', () {
    test('maps a complete Photon response correctly', () {
      final photonExample = {
        "properties": {
          "osm_id": 12345,
          "osm_key": "amenity",
          "osm_value": "restaurant",
          "name": "La Pergola",
          "city": "Rome",
          "county": "Roma",
          "state": "Lazio",
          "country": "Italy",
          "countrycode": "IT",
        },
        "geometry": {
          "coordinates": [12.4964, 41.9028],
        },
      };

      final poi = PoiMapper.mapPoiFromPhoton(photonExample);

      expect(poi.id, '12345');
      expect(poi.name, 'La Pergola');
      expect(poi.city, 'Rome');
      expect(poi.province, 'Roma');
      expect(poi.region, 'Lazio');
      expect(poi.country, 'Italy');
      expect(poi.countrycode, 'IT');
      expect(poi.coordinates, LatLng(12.4964, 41.9028));
      expect(poi.category, isA<PoiCategory>());
    });

    test('maps a Photon response with missing optional values', () {
      final photonExample = {
        "properties": {
          "osm_id": 54321,
          "osm_key": "amenity",
          "osm_value": null,
          "name": "Unknown Place",
          "country": "France",
        },
        "geometry": {
          "coordinates": [2.3522, 48.8566],
        },
      };

      final poi = PoiMapper.mapPoiFromPhoton(photonExample);

      expect(poi.id, '54321');
      expect(poi.name, 'Unknown Place');
      expect(poi.city, null);
      expect(poi.province, null);
      expect(poi.region, null);
      expect(poi.country, 'France');
      expect(poi.category, PoiCategory.unknown); // osm_value = null
      expect(poi.coordinates, LatLng(2.3522, 48.8566));
    });

    test('returns Poi.empty() if response is invalid', () {
      final invalidResponse = {"invalid": "data"};

      final poi = PoiMapper.mapPoiFromPhoton(invalidResponse);

      expect(poi.isEmpty(), true);
      expect(poi.id, '');
      expect(poi.name, '');
      expect(poi.coordinates, LatLng(0, 0));
      expect(poi.category, PoiCategory.unknown);
    });

    test('returns unknown category if type/subtype not in config', () {
      final photonExample = {
        "properties": {
          "osm_id": 99999,
          "osm_key": "nonexistent_type",
          "osm_value": "nonexistent_subtype",
          "name": "Mystery Place",
          "country": "Nowhere",
        },
        "geometry": {
          "coordinates": [0, 0],
        },
      };

      final poi = PoiMapper.mapPoiFromPhoton(photonExample);

      expect(poi.category, PoiCategory.unknown);
    });
  });
}
