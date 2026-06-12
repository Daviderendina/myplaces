class RootState {
  final int selectedIndex; // Show a marker that correspond to the selectedPoi

  const RootState({required this.selectedIndex});

  RootState copyWith({int? selectedIndex}) {
    return RootState(selectedIndex: selectedIndex ?? this.selectedIndex);
  }
}
