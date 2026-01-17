import '../models/poi.dart';
import 'no_value.dart';

class MapPageViewState {
  final List<Poi> searchResults;
  final Poi? searchPoiResultToShow;

  const MapPageViewState({
    this.searchResults = const [],
    this.searchPoiResultToShow,
  });

  MapPageViewState copyWith({
    List<Poi>? searchResults,
    bool? isSearching,
    Object? searchPoiResultToShow = noValue,
  }) {
    return MapPageViewState(
      searchResults: searchResults ?? this.searchResults,
      searchPoiResultToShow: searchPoiResultToShow == noValue
          ? this.searchPoiResultToShow
          : searchPoiResultToShow as Poi?,
    );
  }
}
