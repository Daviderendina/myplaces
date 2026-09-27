import 'package:myplaces/core/models/poi.dart';

class PoiPreview {
  final String id;
  final String name;
  final String positionLabel;
  final String osmType;
  final String photoQuery;

  PoiPreview({
    required this.id,
    required this.name,
    required this.positionLabel,
    this.osmType = '',
    this.photoQuery = '',
  });

  factory PoiPreview.fromPoi(Poi poi) {
    return PoiPreview(
      id: poi.id,
      name: poi.name,
      positionLabel: poi.address.text,
      osmType: poi.osmType,
      photoQuery: poi.name,
    );
  }
}
