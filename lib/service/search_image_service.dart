// commons_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchImageService {
  final String _baseUrl = 'https://commons.wikimedia.org';
  final String _path = '/w/api.php';

  Future<List<String>> searchImages({
    required String query,
    int limit = 5,
    int offset = 0,
  }) async {
    final uri = Uri.https(_baseUrl, _path, {
      'action': 'query',
      'format': 'json',
      'generator': 'search',
      'gsrsearch': query,
      'gsrlimit': limit.toString(),
      'gsroffset': offset.toString(),
      'gsrnamespace': '6',
      'prop': 'imageinfo',
      'iiprop': 'url',
      'iiurlheight': '300',
    });

    print("Searching image from uri ${uri.toString()}");

    final response = await http.get(uri);
    if (response.statusCode != 200) return [];

    final data = jsonDecode(response.body);
    final pages = data['query']?['pages'] ?? {};
    List<String> imageUrls = [];

    pages.forEach((key, page) {
      if (page['imageinfo'] != null && page['imageinfo'].isNotEmpty) {
        imageUrls.add(page['imageinfo'][0]['thumburl']);
      }
    });

    return imageUrls;
  }
}
