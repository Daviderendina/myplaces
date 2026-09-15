import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myplaces/shared/datasource/poi/IPoiDataSource.dart';

class NominatingDataSource implements IPoiDataSource {
  static const _baseUrl = 'nominatim.openstreetmap.org';
  static const _userAgent = 'drendina.myplaces.it';

  final http.Client _client = http.Client();

  @override
  Future<Map<String, dynamic>> search(String query) async {
    final response = await _client.get(
      Uri.https(_baseUrl, '/search', {'q': query, 'format': 'geocodejson', 'addressdetails': '1'}),
      headers: const {'User-Agent': 'MyPlaces', 'accept-language': 'it'},
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw http.ClientException(
        'Nominatim search failed with status ${response.statusCode}',
        response.request?.url,
      );
    }

    final decodedBody = jsonDecode(response.body);
    if (decodedBody is! Map<String, dynamic>) {
      throw const FormatException('Invalid Nominatim response format');
    }

    return decodedBody;
  }
}
