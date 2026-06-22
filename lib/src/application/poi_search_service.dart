import 'dart:convert';
import 'package:http/http.dart' as http;

import '../domain/poi.dart';
import '../../logger.dart';

class PoiSearchService {
  static const String _baseUrl = 'https://photon.komoot.io/api';

  Future<List<Poi>> search(String query) async {
    final String queryParam = "lang=en&q=$query";
    final uri = Uri.parse('$_baseUrl?$queryParam');

    final response = await http.get(uri, headers: {'User-Agent': 'it.drendina.myplaces/1.0'});

    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final List features = body['features'];

    List<Poi> result = features.map((f) => Poi.fromJson(f)).where(filterByType).toList();

    return result;
  }

  bool filterByType(Poi poi) {
    return poi.category != null;
  }
}
