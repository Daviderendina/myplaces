// commons_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchImageService {
  final String _baseUrl = 'https://commons.wikimedia.org';
  final String _path = '/w/api.php';

  Future<List<String>> searchImages({
    required String query,
    int limit = 40,
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

    //https://commons.wikimedia.org/w/api.php?action=query&
    // format=json&
    // uselang=en&
    // generator=search&
    // gsrsearch=filetype%3Abitmap%7Cdrawing%20-fileres%3A0%20filemime%3Ajpeg%20haswbstatement%3AP6731%3DQ63348069%20monte%20generoso&
    // gsrlimit=40&
    // gsroffset=0&
    // gsrinfo=totalhits%7Csuggestion&
    // gsrprop=size%7Cwordcount%7Ctimestamp%7Csnippet&
    // prop=info%7Cimageinfo%7Centityterms&
    // inprop=url&
    // gsrnamespace=6&
    // iiprop=url%7Csize%7Cmime&
    // iiurlheight=180&
    // wbetterms=label

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
