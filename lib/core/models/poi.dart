import 'package:latlong2/latlong.dart';

import '../../../core/models/entity.dart';

class PoiAddress {
  final String text;

  const PoiAddress({this.text = 'Address details not available yet'});
}

class Poi extends Entity {
  final String name;
  final LatLng coordinates;
  final String type;
  final PoiAddress address;
  final String osmType;

  Poi({
    required super.id,
    required this.name,
    required this.coordinates,
    this.type = '',
    this.address = const PoiAddress(),
    this.osmType = '',
  });
}
