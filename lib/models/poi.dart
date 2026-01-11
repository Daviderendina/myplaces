import 'package:latlong2/latlong.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/models/poi_category.dart';
import 'package:myplaces/models/poi_image.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class Poi {
  @Id(assignable: true)
  int obxId = 0;

  final String id;

  String? type;
  String? subtype;

  String name;

  String? city;
  String? province; // county?? tipo provincia
  String? region; // state, cio`e regione
  String? country;
  String? countrycode;

  String categoryName;

  double lat;
  double lng;

  ToMany<PoiImage> images = ToMany();

  ToMany<MyList> lists = ToMany();

  Poi({
    required this.id,
    this.type,
    this.subtype,
    required this.name,
    this.city,
    this.province,
    this.region,
    this.country,
    LatLng? coordinates,
    this.countrycode,
    required this.categoryName,
    this.lat = 0,
    this.lng = 0,
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
    return Poi(
      id: '',
      name: '',
      coordinates: LatLng(0, 0),
      categoryName: PoiCategory.unknown.name,
    );
  }

  String getDisplayAreaName() {
    String location = [
      if (city != null && city!.isNotEmpty) city,
      if (province != null && province!.isNotEmpty) province,
    ].join(', ');

    return location.isEmpty ? "$country" : "$location · $country";
  }
}

// TODO: nella ricerca devo mostrare anche i miei elementi se matchano!!!! Altrimenti mi incasino tutte le liste coi doppiooni!!! NB: l' id per i POI e ubnivoco
