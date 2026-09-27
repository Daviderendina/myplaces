import 'package:latlong2/latlong.dart';
import 'package:myplaces/core/models/poi/poi_preview.dart';

import 'poi_image.dart';

class Poi extends PoiPreview {
  final LatLng coordinates;
  final List<PoiImage> photos;

  List<String> get imageList => photos.map((p) => p.url).toList();

  Poi({
    required super.id,
    required super.name,
    super.address,
    super.type,
    super.photoQuery,
    super.category,
    required this.coordinates,
    this.photos = const [],
  });

  Future<Poi> copyWith({required List<PoiImage> photos}) async {
    return Poi(
      id: id,
      name: name,
      address: address,
      type: type,
      photoQuery: photoQuery,
      category: category,
      coordinates: coordinates,
      photos: photos,
    );
  }
}
