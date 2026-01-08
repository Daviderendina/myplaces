import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myplaces/mapper/poi_mapper.dart';

import '../models/poi.dart';

class PoiSearchService {
  static const String _baseUrl = 'https://photon.komoot.io/api';

  Future<List<Poi>> search(String query) async {
    final String queryParam = "lang=en&q=$query";
    final uri = Uri.parse('$_baseUrl?$queryParam');
    print("Invoking ${uri.toString()}");

    final response = await http.get(
      uri,
      headers: {'User-Agent': 'it.drendina.myplaces/1.0'},
    );

    if (response.statusCode != 200) {
      print(response.reasonPhrase);
      throw Exception('HTTP ${response.statusCode}');
    }

    final body = jsonDecode(response.body) as Map<String, dynamic>;
    final List features = body['features'];
    print("Received ${features.length} responses: $features");

    List<Poi> result = features
        .map((f) => PoiMapper.mapPoiFromPhoton(f))
        .where(filterByType)
        .toList();

    print("Filtered out ${features.length - result.length} poi");
    return result;
  }

  bool filterByType(Poi poi) {
    return poi.category != null;
  }
}
