import '../models/poi.dart';

class MapPageViewState {
  final List<Poi> searchResults;
  final bool isSearching;

  const MapPageViewState({
    this.searchResults = const [],
    this.isSearching = false,
  });

  MapPageViewState copyWith({List<Poi>? searchResults, bool? isSearching}) {
    return MapPageViewState(
      searchResults: searchResults ?? this.searchResults,
      isSearching: isSearching ?? this.isSearching,
    );
  }
}
