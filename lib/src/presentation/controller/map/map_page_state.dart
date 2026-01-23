class MapPageState {
  final bool showPoiMarker; // Show a marker that correspond to the selectedPoi

  const MapPageState({this.showPoiMarker = false});

  MapPageState copyWith({bool? showPoiMarker}) {
    return MapPageState(showPoiMarker: showPoiMarker ?? this.showPoiMarker);
  }
}
