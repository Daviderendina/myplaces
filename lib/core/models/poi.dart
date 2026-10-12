import 'package:latlong2/latlong.dart';
import 'package:myplaces/core/models/poi/poi_address.dart';
import 'package:myplaces/core/models/poi/poi_preview.dart';
import 'package:myplaces/features/collections/models/collection.dart';
import 'package:myplaces/features/trips/models/trip.dart';

import 'poi_image.dart';

class Poi extends PoiPreview {
  final LatLng coordinates;
  final List<PoiImage> photos;
  final List<Collection> collectionsBelonged;
  final List<Trip> tripsBelonged;

  List<String> get imageList => photos.map((p) => p.url).toList();

  Poi({
    required super.id,
    required super.name,
    super.address,
    required super.type,
    required super.category,
    required this.coordinates,
    this.photos = const [],
    this.collectionsBelonged = const [],
    this.tripsBelonged = const [],
  });

  Poi copyWith({
    List<PoiImage>? photos,
    List<Collection>? collectionsBelonged,
    List<Trip>? tripsBelonged,
    PoiAddress? address,
  }) {
    return Poi(
      id: id,
      name: name,
      address: address ?? this.address,
      type: type,
      category: category,
      coordinates: coordinates,
      photos: photos ?? this.photos,
      collectionsBelonged: collectionsBelonged ?? this.collectionsBelonged,
      tripsBelonged: tripsBelonged ?? this.tripsBelonged,
    );
  }
}
