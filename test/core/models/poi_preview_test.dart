import 'package:flutter_test/flutter_test.dart';
import 'package:myplaces/core/models/poi/poi_address.dart';
import 'package:myplaces/core/models/poi/poi_category.dart';
import 'package:myplaces/core/models/poi/poi_preview.dart';

void main() {
  group('PoiPreview positionLabel', () {
    test('formats city, county, country, and countryCode correctly', () {
      final preview = PoiPreview(
        id: '1',
        name: 'Test',
        type: 'way',
        category: PoiCategory.other,
        address: PoiAddress(
          city: 'Rho',
          county: 'Milano',
          country: 'Italia',
          countryCode: 'it',
        ),
      );

      expect(preview.positionLabel, 'Rho, Milano, Italia (IT)');
    });

    test('omits county when city and county are equal (case-insensitive)', () {
      final preview = PoiPreview(
        id: '1',
        name: 'Test',
        type: 'way',
        category: PoiCategory.other,
        address: PoiAddress(
          city: 'Milano',
          county: 'milano',
          country: 'Italia',
          countryCode: 'IT',
        ),
      );

      expect(preview.positionLabel, 'Milano, Italia (IT)');
    });

    test('omits null or empty fields', () {
      final preview = PoiPreview(
        id: '1',
        name: 'Test',
        type: 'way',
        category: PoiCategory.other,
        address: PoiAddress(
          city: 'Rho',
          country: 'Italia',
          countryCode: 'IT',
        ),
      );

      expect(preview.positionLabel, 'Rho, Italia (IT)');
    });

    test('returns empty string when address or fields are null', () {
      final previewNullAddress = PoiPreview(
        id: '1',
        name: 'Test',
        type: 'way',
        category: PoiCategory.other,
        address: null,
      );

      expect(previewNullAddress.positionLabel, '');

      final previewEmptyAddress = PoiPreview(
        id: '1',
        name: 'Test',
        type: 'way',
        category: PoiCategory.other,
        address: PoiAddress(),
      );

      expect(previewEmptyAddress.positionLabel, '');
    });
  });
}
