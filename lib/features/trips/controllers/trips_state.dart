import '../models/trip.dart';

class TripsState {
  final List<Trip> allTrips;
  final List<Trip> displayedTrips;

  const TripsState({
    this.allTrips = const [],
    this.displayedTrips = const [],
  });

  int get allCount => allTrips.length;
  bool get isFiltered => allTrips.length != displayedTrips.length;

  TripsState copyWith({
    List<Trip>? allTrips,
    List<Trip>? displayedTrips,
  }) {
    return TripsState(
      allTrips: allTrips ?? this.allTrips,
      displayedTrips: displayedTrips ?? this.displayedTrips,
    );
  }
}
