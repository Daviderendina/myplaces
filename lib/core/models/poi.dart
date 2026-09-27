import 'package:latlong2/latlong.dart';

import '../../../core/models/entity.dart';
import 'poi_image.dart';

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
  final List<PoiImage> photos;

  get imageList => photos.map((p) => p.url).toList();

  Poi({
    required super.id,
    required this.name,
    required this.coordinates,
    this.type = '',
    this.address = const PoiAddress(),
    this.osmType = '',
    this.photos = const [],
  });

  Poi copyWith({
    String? id,
    String? name,
    LatLng? coordinates,
    String? type,
    PoiAddress? address,
    String? osmType,
    List<PoiImage>? photos,
  }) {
    return Poi(
      id: id ?? this.id,
      name: name ?? this.name,
      coordinates: coordinates ?? this.coordinates,
      type: type ?? this.type,
      address: address ?? this.address,
      osmType: osmType ?? this.osmType,
      photos: photos ?? this.photos,
    );
  }
}
