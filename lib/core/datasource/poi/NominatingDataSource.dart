import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'IPoiDataSource.dart';

class NominatingDataSource implements IPoiDataSource {
  static const _baseUrl = 'nominatim.openstreetmap.org';

  final http.Client _client = http.Client();

  @override
  Future<Map<String, dynamic>> search(String query) async {
    final response = await _client.get(
      Uri.https(_baseUrl, '/search', {'q': query, 'format': 'geocodejson', 'addressdetails': '1'}),
      headers: const {'User-Agent': 'MyPlaces', 'accept-language': 'it'},
    );

    return _handleResponse(response, 'search');
  }

  @override
  Future<Map<String, dynamic>> searchByIdAndType(String type, String id) async {
    final response = await _client.get(
      Uri.https(_baseUrl, '/details', {
        'osmtype': type.characters.first.toUpperCase(),
        'osmid': id.toString(),
      }),
      headers: const {'User-Agent': 'MyPlaces', 'accept-language': 'it'},
    );

    return _handleResponse(response, 'details');
  }

  Map<String, dynamic> _handleResponse(http.Response response, String operation) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw http.ClientException(
        'Nominatim $operation failed with status ${response.statusCode}',
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
