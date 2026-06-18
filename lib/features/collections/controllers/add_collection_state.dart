class AddCollectionState {
  final String? name;
  final String? emoji;
  final bool isSaving;

  AddCollectionState({this.name, this.emoji, this.isSaving = false});

  AddCollectionState copyWith({String? name, String? emoji, bool? isSaving}) {
    return AddCollectionState(
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      isSaving: isSaving ?? this.isSaving,
    );
  }
}
