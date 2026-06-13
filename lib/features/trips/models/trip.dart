import '../../../core/models/entity.dart';

class Trip extends Entity {
  final String name;

  Trip({
    required super.id,
    required this.name,
  });

  Trip copyWith({
    String? id,
    String? name,
  }) {
    return Trip(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
