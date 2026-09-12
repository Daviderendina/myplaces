import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/map/controllers/main_map_state.dart';
import 'package:myplaces/core/models/poi.dart';

class MainMapController extends Notifier<MainMapState> {
  @override
  MainMapState build() {
    return const MainMapState();
  }

  // TODO qui devo fare anche la gestione delle visible lists tramite il service

  Future<void> onSearchTap(BuildContext context) async {
    final Poi? result = await context.push<Poi>('/search');
    if (result != null) {
      selectPoi(result);
    }
  }

  void selectPoi(Poi poi) {
    state = state.copyWith(
      selectedPoi: poi,
      cameraMoveTarget: poi.coordinates,
      targetZoom: 7.0,
      targetOffset: Offset(0, -AppLayout.screenHeight * .22),
    );
  }

  void clearSelection() {
    state = const MainMapState();
  }
}
