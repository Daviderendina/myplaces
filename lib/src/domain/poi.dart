import 'package:latlong2/latlong.dart';
import 'package:myplaces/src/domain/my_list.dart';
import 'package:myplaces/src/domain/poi_category.dart';
import 'package:myplaces/src/domain/poi_image.dart';

import '../config/poi_categories_mapping.dart';

class Poi {
  int obxId = 0;

  final String id;

  String? type;
  String? subtype;

  String name;

  String? city;
  String? province; 
  String? region; 
  String? country;
  String? countrycode;

  String categoryName;

  String note;

  double lat;
  double lng;

  List<PoiImage> images = [];

  List<MyList> lists = [];

  Poi({
    required this.id,
    this.type,
    this.subtype,
    required this.name,
    this.city,
    this.province,
    this.region,
    this.country,
    this.countrycode,
    required this.categoryName,
    this.lat = 0,
    this.lng = 0,
    this.note = '',
  });

  LatLng get coordinates => LatLng(lat, lng);

  PoiCategory get category => PoiCategory.values.byName(categoryName);

  void setImages(List<PoiImage> newImages) {
    for (var image in newImages) {
      if (!images.any((i) => i.thumbnail == image.thumbnail)) {
        images.add(image);
      }
    }
  }

  bool isEmpty() {
    return id.isEmpty && name.isEmpty;
  }

  factory Poi.empty() {
    return Poi(id: '', name: '', categoryName: PoiCategory.unknown.name);
  }

  String getDisplayAreaName() {
    String location = [
      if (city != null && city!.isNotEmpty) city,
      if (province != null && province!.isNotEmpty) province,
    ].join(', ');

    return location.isEmpty ? "$country" : "$location · $country";
  }

  bool belongToList(int listId) {
    return lists.map((l) => l.id).toList().contains(listId);
  }

  void setObxId(int obxId) => this.obxId = obxId;

  @override
  String toString() {
    return 'Poi(obxId: $obxId, id: $id, type: $type, subtype: $subtype, name: $name, city: $city, province: $province, region: $region, country: $country, countrycode: $countrycode, categoryName: $categoryName, note: $note, lat: $lat, lng: $lng, coordinates: ${coordinates.latitude},${coordinates.longitude}, images: [${images.map((i) => i.thumbnail).join(', ')}], lists: [${lists.map((l) => l.name).join(', ')}])';
  }

  factory Poi.fromJson(Map<String, dynamic> json) {
    PoiCategory findCategoryByTypeAndSubtype(String type, String subtype) {
      return poiCategoriesMapping["$type|$subtype"] ??
          poiCategoriesMapping["$type|*"] ??
          PoiCategory.unknown;
    }

    try {
      final properties = json['properties'];
      final geometry = json['geometry'];

      Poi result = Poi(
        id: properties['osm_id'].toString(),
        type: properties['osm_key'],
        subtype: properties['osm_value'],
        categoryName: findCategoryByTypeAndSubtype(
          properties['osm_key'],
          properties['osm_value'],
        ).name,
        name: properties['name'],
        city: properties['city'],
        province: properties['county'],
        region: properties['state'],
        country: properties['country'],
        countrycode: properties['countrycode'],
        lat: geometry['coordinates'][1],
        lng: geometry['coordinates'][0],
      );

      return result;
    } catch (error) {
      return Poi.empty();
    }
  }
}

extension PoiCopy on Poi {
  Poi copy({
    String? type,
    String? subtype,
    String? name,
    String? city,
    String? province,
    String? region,
    String? country,
    String? countrycode,
    String? categoryName,
    String? note,
    double? lat,
    double? lng,
    List<PoiImage>? images,
    List<MyList>? lists,
  }) {
    final clonedPoi = Poi(
      id: this.id,
      type: type ?? this.type,
      subtype: subtype ?? this.subtype,
      name: name ?? this.name,
      city: city ?? this.city,
      province: province ?? this.province,
      region: region ?? this.region,
      country: country ?? this.country,
      countrycode: countrycode ?? this.countrycode,
      categoryName: categoryName ?? this.categoryName,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      note: note ?? this.note,
    );

    clonedPoi.images.addAll(images ?? this.images);
    clonedPoi.lists.addAll(lists ?? this.lists);
    clonedPoi.obxId = this.obxId;

    return clonedPoi;
  }
}
