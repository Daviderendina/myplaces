abstract class IPoiDataSource {
  Future<Map<String, dynamic>> search(String query);

  Future<Map<String, dynamic>> searchByIdAndType(String type, String id);
}
