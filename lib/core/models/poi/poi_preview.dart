import 'package:myplaces/core/models/entity.dart';
import 'package:myplaces/core/models/poi/poi_address.dart';
import 'package:myplaces/core/models/poi/poi_category.dart';

class PoiPreview extends Entity {
  final String name;
  final String type;
  final PoiCategory category;
  final PoiAddress? address;

  String get positionLabel {
    final parts = <String>[];

    final city = address?.city?.trim();
    final county = address?.county?.trim();
    final country = address?.country?.trim();
    final countryCode = address?.countryCode?.trim().toUpperCase();

    if (city != null && city.isNotEmpty) {
      parts.add(city);
    }

    if (county != null && county.isNotEmpty) {
      if (city == null || city.toLowerCase() != county.toLowerCase()) {
        parts.add(county);
      }
    }

    if (country != null && country.isNotEmpty) {
      if (countryCode != null && countryCode.isNotEmpty) {
        parts.add('$country ($countryCode)');
      } else {
        parts.add(country);
      }
    } else if (countryCode != null && countryCode.isNotEmpty) {
      parts.add('($countryCode)');
    }

    return parts.join(', ');
  }

  String get countryCode => address?.countryCode ?? '';

  PoiPreview({
    required super.id,
    required this.name,
    required this.type,
    required this.category,
    this.address,
  });
}
