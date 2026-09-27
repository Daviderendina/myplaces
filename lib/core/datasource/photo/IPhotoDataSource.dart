abstract class IPhotoDataSource {
  Future<Map<String, dynamic>> search(String query);
}
