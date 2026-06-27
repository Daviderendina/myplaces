import 'package:latlong2/latlong.dart';

import '../../../core/models/entity.dart';

class Poi extends Entity {
  final String name;
  final LatLng coordinates;

  Poi({required super.id, required this.name, required this.coordinates});
}
