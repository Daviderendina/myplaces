import '../models/collection.dart';

class CollectionsState {
  final List<Collection> allCollections;
  final List<Collection> displayedCollections;

  const CollectionsState({
    this.allCollections = const [],
    this.displayedCollections = const [],
  });

  int get allCount => allCollections.length;
  bool get isFiltered => allCollections.length != displayedCollections.length;

  CollectionsState copyWith({
    List<Collection>? allCollections,
    List<Collection>? displayedCollections,
  }) {
    return CollectionsState(
      allCollections: allCollections ?? this.allCollections,
      displayedCollections: displayedCollections ?? this.displayedCollections,
    );
  }
}
