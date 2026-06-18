import 'dart:ui';

import '../../../core/models/entity.dart';

class Collection extends Entity {
  final String name;
  final String emoji;
  final Color? dominantEmojiColor;

  // TODO questa deve essere passata usando il metodo delle util quando si fa il salvataggio/modifica della moeji

  Collection({required super.id, required this.name, required this.emoji, this.dominantEmojiColor});

  Collection copyWith({String? id, String? name, String? emoji, Color? dominantEmojiColor}) {
    return Collection(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      dominantEmojiColor: dominantEmojiColor ?? this.dominantEmojiColor,
    );
  }
}
