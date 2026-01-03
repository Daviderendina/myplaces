import '../models/poi.dart';

abstract class PoiRepository {
  Future<List<Poi>> search(String query);
}
