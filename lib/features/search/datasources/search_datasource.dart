import 'dart:async';

abstract class SearchDataSource {
  Future<List<Map<String, dynamic>>> searchPois(String query);
}

class MockSearchDataSource implements SearchDataSource {
  final List<Map<String, dynamic>> _mockData = [
    {
      'properties': {
        'osm_id': 1,
        'osm_key': 'amenity',
        'osm_value': 'restaurant',
        'name': 'Pizzeria da Mario',
        'city': 'Roma',
        'county': 'Roma',
        'state': 'Lazio',
        'country': 'Italy',
        'countrycode': 'IT',
      },
      'geometry': {
        'coordinates': [12.4964, 41.9028]
      }
    },
    {
      'properties': {
        'osm_id': 2,
        'osm_key': 'tourism',
        'osm_value': 'museum',
        'name': 'Musei Vaticani',
        'city': 'Città del Vaticano',
        'county': 'Città del Vaticano',
        'state': 'Lazio',
        'country': 'Vatican City',
        'countrycode': 'VA',
      },
      'geometry': {
        'coordinates': [12.4539, 41.9065]
      }
    },
    {
      'properties': {
        'osm_id': 3,
        'osm_key': 'historic',
        'osm_value': 'monument',
        'name': 'Colosseo',
        'city': 'Roma',
        'county': 'Roma',
        'state': 'Lazio',
        'country': 'Italy',
        'countrycode': 'IT',
      },
      'geometry': {
        'coordinates': [12.4922, 41.8902]
      }
    },
  ];

  @override
  Future<List<Map<String, dynamic>>> searchPois(String query) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 300));
    
    if (query.isEmpty) return [];
    
    return _mockData.where((poi) {
      final name = poi['properties']['name'].toString().toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();
  }
}
