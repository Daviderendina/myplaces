import 'dart:ui';

import 'package:latlong2/latlong.dart';
import 'package:myplaces/core/models/poi.dart';
import 'package:myplaces/features/collections/models/collection.dart';

enum PoiSelectionStatus { notSet, loading, error, loaded }

class MainMapState {
  final Poi? selectedPoi;
  final PoiSelectionStatus selectedPoiStatus;
  final bool? showSelectedPoiMarker;
  final LatLng? cameraMoveTarget;
  final double? targetZoom;
  final Offset? targetOffset;
  final List<Collection> visibleCollections;

  const MainMapState({
    this.selectedPoi,
    this.showSelectedPoiMarker,
    this.selectedPoiStatus = PoiSelectionStatus.notSet,
    this.cameraMoveTarget,
    this.targetZoom,
    this.targetOffset,
    this.visibleCollections = const [],
  });

  MainMapState copyWith({
    Poi? selectedPoi,
    bool? showSelectedPoiMarker,
    PoiSelectionStatus? selectedPoiStatus,
    LatLng? cameraMoveTarget,
    double? targetZoom,
    Offset? targetOffset,
    bool clearSelectedPoi = false,
    bool clearCameraTarget = false,
    List<Collection>? visibleCollections,
  }) {
    return MainMapState(
      selectedPoi: clearSelectedPoi ? null : (selectedPoi ?? this.selectedPoi),
      showSelectedPoiMarker: showSelectedPoiMarker ?? this.showSelectedPoiMarker,
      selectedPoiStatus: selectedPoiStatus ?? this.selectedPoiStatus,
      cameraMoveTarget: clearCameraTarget ? null : (cameraMoveTarget ?? this.cameraMoveTarget),
      targetZoom: clearCameraTarget ? null : (targetZoom ?? this.targetZoom),
      targetOffset: clearCameraTarget ? null : (targetOffset ?? this.targetOffset),
      visibleCollections: visibleCollections ?? this.visibleCollections,
    );
  }
}
