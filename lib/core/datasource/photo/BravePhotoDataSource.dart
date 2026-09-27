import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/AppConfig.dart';
import 'IPhotoDataSource.dart';

class BravePhotoDataSource implements IPhotoDataSource {
  static const _baseUrl = 'api.search.brave.com';
  final http.Client _client = http.Client();

  @override
  Future<Map<String, dynamic>> search(String query) async {
    final response = await _client.get(
      Uri.https(_baseUrl, '/res/v1/images/search', {'q': query}),
      headers: const {
        'X-Subscription-Token': AppConfig.braveApiKey,
        'Accept': 'application/json',
        'Accept-Encoding': 'gzip',
      },
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw http.ClientException(
        'Brave images search failed with status ${response.statusCode}',
        response.request?.url,
      );
    }

    final decodedBody = jsonDecode(response.body);
    if (decodedBody is! Map<String, dynamic>) {
      throw const FormatException('Invalid Brave images response format');
    }

    return decodedBody;
  }
}
