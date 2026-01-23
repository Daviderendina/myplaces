import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myplaces/src/domain/poi_image.dart';

import '../domain/poi.dart';

class ImageService {
  Future<Poi> enrichPoiWithImages({
    required Poi poi,
    int limit = 2 /*15*/,
  }) async {
    final queryString = [
      if (poi.name.isNotEmpty) 'intitle:$poi.name',
      if (poi.city != null && poi.city!.isNotEmpty) 'intitle:$poi.city',
      if (poi.country != null && poi.country!.isNotEmpty)
        'intitle:$poi.country',
    ].join(' ');

    final uri = Uri.https(
      'commons.wikimedia.org', // BASE URL corretto (senza https://)
      '/w/api.php', // path
      {
        'action': 'query',
        'format': 'json',
        'generator': 'search',
        'gsrsearch': queryString,
        'gsrlimit': limit.toString(),
        'gsrnamespace': '6', // solo file/immagini
        'prop': 'imageinfo',
        'iiprop': 'url',
        'iiurlheight': '300',
      },
    );

    // print("Searching image from uri ${uri.toString()}");

    final response = await http.get(uri);
    if (response.statusCode != 200) return poi;

    final data = jsonDecode(response.body);
    final pages = data['query']?['pages'] ?? {};

    List<PoiImage> images = [];

    pages.forEach((key, page) {
      if (page['imageinfo'] != null && page['imageinfo'].isNotEmpty) {
        final imageInfo = page['imageinfo'][0];
        images.add(
          PoiImage(
            thumbnail: imageInfo['thumburl'],
            imageUrl: imageInfo['url'],
          ),
        );
      }
    });

    poi.images.addAll(images);
    return poi;
  }
}
