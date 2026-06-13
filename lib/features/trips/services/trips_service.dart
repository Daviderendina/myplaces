import '../models/trip.dart';

class TripsService {
  Future<List<Trip>> getTrips() async {
    // Mocked data
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Trip(id: '1', name: 'Estate 2024 - Grecia'),
      Trip(id: '2', name: 'Weekend a Parigi'),
      Trip(id: '3', name: 'Tour della Toscana'),
    ];
  }
}
