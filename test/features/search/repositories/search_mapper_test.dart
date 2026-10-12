import 'package:flutter_test/flutter_test.dart';
import 'package:myplaces/core/models/poi/poi_category.dart';
import 'package:myplaces/features/search/repositories/search_mapper.dart';

void main() {
  group('SearchMapper', () {
    late SearchMapper mapper;

    setUp(() {
      mapper = SearchMapper();
    });

    test('maps a valid feature with all geocoding address fields', () {
      final data = {
        'features': [
          {
            'properties': {
              'geocoding': {
                'name': 'Ospedale Giuseppe Casati',
                'label': 'Ospedale Giuseppe Casati, 1, Via Luigi Settembrini, Passirana, Rho, Milano, Lombardia, 20017, Italia',
                'osm_type': 'way',
                'osm_id': 64096034,
                'osm_key': 'amenity',
                'osm_value': 'hospital',
                'housenumber': '1',
                'postcode': '20017',
                'street': 'Via Luigi Settembrini',
                'district': 'Passirana',
                'city': 'Rho',
                'county': 'Milano',
                'state': 'Lombardia',
                'country': 'Italia',
                'country_code': 'it',
              },
            },
          },
        ],
      };

      final result = mapper.map(data);

      expect(result, hasLength(1));
      final poi = result.first;
      expect(poi.id, '64096034');
      expect(poi.name, 'Ospedale Giuseppe Casati');
      expect(poi.type, 'way');
      expect(poi.category, PoiCategory.other);

      final address = poi.address;
      expect(address, isNotNull);
      expect(address?.houseNumber, '1');
      expect(address?.postcode, '20017');
      expect(address?.street, 'Via Luigi Settembrini');
      expect(address?.district, 'Passirana');
      expect(address?.city, 'Rho');
      expect(address?.county, 'Milano');
      expect(address?.state, 'Lombardia');
      expect(address?.country, 'Italia');
      expect(address?.countryCode, 'IT');
    });

    test('maps String osm_id correctly', () {
      final data = {
        'features': [
          {
            'properties': {
              'geocoding': {
                'name': 'Piazza Duomo',
                'label': 'Piazza Duomo, Milano',
                'osm_type': 'node',
                'osm_id': '123456',
              },
            },
          },
        ],
      };

      final result = mapper.map(data);

      expect(result, hasLength(1));
      expect(result.first.id, '123456');
    });

    test('throws FormatException when features is not a List', () {
      expect(() => mapper.map({'features': 'not_a_list'}), throwsA(isA<FormatException>()));
      expect(() => mapper.map({'features': null}), throwsA(isA<FormatException>()));
      expect(() => mapper.map({}), throwsA(isA<FormatException>()));
    });

    test('returns empty list when features is empty', () {
      final result = mapper.map({'features': []});
      expect(result, isEmpty);
    });

    test('skips non-map items in features list', () {
      final data = {
        'features': ['invalid_string', 123, null],
      };

      final result = mapper.map(data);

      expect(result, isEmpty);
    });

    test('skips features missing properties or geocoding', () {
      final data = {
        'features': [
          {},
          {'properties': null},
          {'properties': {}},
          {'properties': {'geocoding': null}},
        ],
      };

      final result = mapper.map(data);

      expect(result, isEmpty);
    });

    test('returns empty list when geocoding response contains all nulls', () {
      final data = {
        'features': [
          {
            'properties': {
              'geocoding': {
                'name': null,
                'label': null,
                'osm_type': null,
                'osm_id': null,
                'housenumber': null,
                'postcode': null,
                'street': null,
                'city': null,
                'country': null,
                'country_code': null,
              },
            },
          },
        ],
      };

      final result = mapper.map(data);

      expect(result, isEmpty);
    });

    test('returns empty list when required fields are missing or empty', () {
      // 1. Missing name
      expect(mapper.map({
        'features': [
          {
            'properties': {
              'geocoding': {'label': 'L', 'osm_type': 'N', 'osm_id': 1},
            },
          },
        ],
      }), isEmpty);

      // 2. Missing label
      expect(mapper.map({
        'features': [
          {
            'properties': {
              'geocoding': {'name': 'N', 'osm_type': 'N', 'osm_id': 1},
            },
          },
        ],
      }), isEmpty);

      // 3. Missing osm_type
      expect(mapper.map({
        'features': [
          {
            'properties': {
              'geocoding': {'name': 'N', 'label': 'L', 'osm_id': 1},
            },
          },
        ],
      }), isEmpty);

      // 4. Missing osm_id
      expect(mapper.map({
        'features': [
          {
            'properties': {
              'geocoding': {'name': 'N', 'label': 'L', 'osm_type': 'N'},
            },
          },
        ],
      }), isEmpty);

      // 5. Empty string values
      expect(mapper.map({
        'features': [
          {
            'properties': {
              'geocoding': {'name': '', 'label': 'L', 'osm_type': 'N', 'osm_id': 1},
            },
          },
        ],
      }), isEmpty);
    });

    test('maps feature with partial address fields', () {
      final data = {
        'features': [
          {
            'properties': {
              'geocoding': {
                'name': 'Colosseo',
                'label': 'Colosseo, Roma, Italia',
                'osm_type': 'way',
                'osm_id': 98765,
                'city': 'Roma',
                'country': 'Italia',
              },
            },
          },
        ],
      };

      final result = mapper.map(data);

      expect(result, hasLength(1));
      final poi = result.first;
      expect(poi.name, 'Colosseo');
      expect(poi.address?.city, 'Roma');
      expect(poi.address?.country, 'Italia');
      expect(poi.address?.street, isNull);
      expect(poi.address?.houseNumber, isNull);
    });
  });
}
