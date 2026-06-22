import '../../../core/models/entity.dart';

class Coordinates {
  final double latitude;
  final double longitude;

  const Coordinates({required this.latitude, required this.longitude});
}

class Poi extends Entity {
  final String name;
  final Coordinates coordinates;

  Poi({required super.id, required this.name, required this.coordinates});
}
