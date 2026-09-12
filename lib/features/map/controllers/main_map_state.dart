import 'dart:ui';

import 'package:latlong2/latlong.dart';
import 'package:myplaces/core/models/poi.dart';

class MainMapState {
  final Poi? selectedPoi;
  final LatLng? cameraMoveTarget;
  final double? targetZoom;
  final Offset? targetOffset;

  const MainMapState({
    this.selectedPoi,
    this.cameraMoveTarget,
    this.targetZoom,
    this.targetOffset,
  });

  MainMapState copyWith({
    Poi? selectedPoi,
    LatLng? cameraMoveTarget,
    double? targetZoom,
    Offset? targetOffset,
    bool clearCameraTarget = false,
  }) {
    return MainMapState(
      selectedPoi: selectedPoi ?? this.selectedPoi,
      cameraMoveTarget: clearCameraTarget
          ? null
          : (cameraMoveTarget ?? this.cameraMoveTarget),
      targetZoom: clearCameraTarget ? null : (targetZoom ?? this.targetZoom),
      targetOffset: targetOffset,
    );
  }
}
