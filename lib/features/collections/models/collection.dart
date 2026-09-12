import 'package:myplaces/features/collections/models/emoji.dart';
import '../../../core/models/entity.dart';
import '../../../core/models/poi.dart';

class Collection extends Entity {
  final String name;
  final MyEmoji emoji;
  final List<Poi> pois;
  final bool visibleOnMap; // TODO non è attributo di una collection

  Collection({
    required super.id,
    required this.name,
    required this.emoji,
    this.pois = const [],
    this.visibleOnMap = true,
  });

  Collection copyWith({
    String? id,
    String? name,
    MyEmoji? emoji,
    List<Poi>? pois,
    bool? visibleOnMap,
  }) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      pois: pois ?? this.pois,
      visibleOnMap: visibleOnMap ?? this.visibleOnMap,
    );
  }
}
