import 'package:myplaces/features/collections/models/emoji.dart';
import '../../../core/models/entity.dart';
import '../../../core/models/poi.dart';

class Collection extends Entity {
  final String name;
  final MyEmoji emoji;
  final List<Poi> pois;

  Collection({required super.id, required this.name, required this.emoji, this.pois = const []});

  Collection copyWith({String? id, String? name, MyEmoji? emoji, List<Poi>? pois}) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      pois: pois ?? this.pois,
    );
  }
}
