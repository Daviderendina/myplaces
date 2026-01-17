class MapPageState {
  final bool showPoiMarker; // Show a marker that correspond to the selectedPoi

  const MapPageState({this.showPoiMarker = false});

  MapPageState copyWith({
    Object? poiToShow,
    bool? showPoiDetailModal,
    bool? showPoiMarker,
  }) {
    return MapPageState(showPoiMarker: showPoiMarker ?? this.showPoiMarker);
  }
}
