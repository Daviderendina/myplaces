abstract class IPoiDataSource {
  Future<Map<String, dynamic>> search(String query);
}
