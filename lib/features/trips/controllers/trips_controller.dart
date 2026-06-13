import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/trip.dart';
import '../providers.dart';
import 'trips_state.dart';

class TripsController extends AsyncNotifier<TripsState> {
  @override
  Future<TripsState> build() async {
    final service = ref.watch(tripsServiceProvider);
    final trips = await service.getTrips();
    
    return TripsState(
      allTrips: trips,
      displayedTrips: trips,
    );
  }

  void filter(String query) {
    final currentState = state.value;
    if (currentState == null) return;

    if (query.isEmpty) {
      state = AsyncData(currentState.copyWith(
        displayedTrips: currentState.allTrips,
      ));
    } else {
      final filtered = currentState.allTrips
          .where((t) => t.name.toLowerCase().contains(query.toLowerCase()))
          .toList();

      state = AsyncData(currentState.copyWith(
        displayedTrips: filtered,
      ));
    }
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(tripsServiceProvider);
      final trips = await service.getTrips();
      return TripsState(
        allTrips: trips,
        displayedTrips: trips,
      );
    });
  }
}
