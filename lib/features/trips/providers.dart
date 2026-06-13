import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'controllers/trips_controller.dart';
import 'controllers/trips_state.dart';
import 'services/trips_service.dart';

final tripsServiceProvider = Provider<TripsService>((ref) {
  return TripsService();
});

final tripsControllerProvider = AsyncNotifierProvider<TripsController, TripsState>(() {
  return TripsController();
});
