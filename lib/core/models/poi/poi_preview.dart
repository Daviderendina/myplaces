import 'package:myplaces/core/models/entity.dart';
import 'package:myplaces/core/models/poi/poi_address.dart';
import 'package:myplaces/core/models/poi/poi_category.dart';

class PoiPreview extends Entity {
  // TODO questo deve essere classe padre del POI
  final String name;
  final String type;
  final String photoQuery;
  final PoiCategory category;
  final PoiAddress address;

  String get positionLabel => 'Via de Gulfus, Rho, Milano (IT)';

  PoiPreview({
    required super.id,
    required this.name,
    this.address = const PoiAddress(),
    this.type = '',
    this.photoQuery = '',
    this.category = PoiCategory.unknown,
  });
}
