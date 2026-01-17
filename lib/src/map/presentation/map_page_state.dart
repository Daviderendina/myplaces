import '../../../models/poi.dart';
import '../../../state/no_value.dart';

class MapPageState {
  final Poi? poiToShow;
  final bool showPoiMarker;

  const MapPageState({this.poiToShow, this.showPoiMarker = false});

  MapPageState copyWith({
    Object? poiToShow,
    bool? showPoiDetailModal,
    bool? showPoiMarker,
  }) {
    return MapPageState(
      poiToShow: poiToShow == noValue ? this.poiToShow : poiToShow as Poi?,
      showPoiMarker: showPoiMarker ?? this.showPoiMarker,
    );
  }
}
