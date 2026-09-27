import '../models/poi/poi_category.dart';

final foodTags = <String>{
  // Ristorazione
  'amenity|bar',
  'amenity|bbq',
  'amenity|biergarten',
  'amenity|cafe',
  'amenity|fast_food',
  'amenity|food_court',
  'amenity|ice_cream',
  'amenity|pub',
  'amenity|restaurant',

  // Negozi alimentari
  'shop|bakery',
  'shop|beverages',
  'shop|butcher',
  'shop|cheese',
  'shop|chocolate',
  'shop|coffee',
  'shop|confectionery',
  'shop|deli',
  'shop|farm',
  'shop|food',
  'shop|frozen_food',
  'shop|pastry',
  'shop|seafood',
  'shop|tea',
  'shop|wine',

  // Produzione alimentare
  'craft|bakery',
  'craft|brewery',
  'craft|winery',
};

final accommodationTags = <String>{
  'tourism|alpine_hut',
  'tourism|apartment',
  'tourism|camp_pitch',
  'tourism|camp_site',
  'tourism|caravan_site',
  'tourism|chalet',
  'tourism|guest_house',
  'tourism|hostel',
  'tourism|hotel',
  'tourism|motel',
  'tourism|wilderness_hut',

  'building|chalet',
  'building|hotel',
  'building|hostel',
};

final religionTags = <String>{
  'amenity|place_of_worship',
  'amenity|grave_yard',
  'amenity|crematorium',

  'building|cathedral',
  'building|chapel',
  'building|church',
  'building|kingdom_hall',
  'building|monastery',
  'building|mosque',
  'building|religious',
  'building|shrine',
  'building|synagogue',
  'building|temple',

  'landuse|cemetery',

  'historic|grave',
  'historic|wayside_cross',
  'historic|wayside_shrine',
};

final historicTags = <String>{
  'historic|archaeological_site',
  'historic|bunker',
  'historic|castle',
  'historic|city_gate',
  'historic|fort',
  'historic|fortification',
  'historic|manor',
  'historic|memorial',
  'historic|milestone',
  'historic|monument',
  'historic|palace',
  'historic|ruins',
  'historic|tank',
  'historic|tower',
  'historic|wreck',

  'building|castle',
  'building|fort',
  'building|manor',
  'building|palace',
  'building|ruins',

  'heritage|yes',
};

final cultureTags = <String>{
  'amenity|arts_centre',
  'amenity|cinema',
  'amenity|community_centre',
  'amenity|conference_centre',
  'amenity|library',
  'amenity|music_venue',
  'amenity|museum',
  'amenity|planetarium',
  'amenity|theatre',
  'amenity|university',

  'building|museum',

  'tourism|gallery',
  'tourism|museum',

  'tourism|artwork',
  'artwork|bust',
  'artwork|installation',
  'artwork|mural',
  'artwork|painting',
  'artwork|sculpture',
  'artwork|statue',
};

final tourismTags = <String>{
  'tourism|aquarium',
  'tourism|attraction',
  'tourism|information',
  'tourism|picnic_site',
  'tourism|theme_park',
  'tourism|viewpoint',
  'tourism|zoo',

  'information|board',
  'information|guidepost',
  'information|map',
  'information|office',
  'information|terminal',

  'leisure|amusement_arcade',
  'leisure|miniature_golf',
  'leisure|water_park',

  'amenity|casino',
  'amenity|nightclub',
};

final sportTags = <String>{
  'leisure|fitness_centre',
  'leisure|fitness_station',
  'leisure|golf_course',
  'leisure|ice_rink',
  'leisure|pitch',
  'leisure|sports_centre',
  'leisure|stadium',
  'leisure|swimming_pool',
  'leisure|track',

  'building|pavilion',
  'building|sports_centre',
  'building|stadium',

  'sport|athletics',
  'sport|basketball',
  'sport|climbing',
  'sport|golf',
  'sport|gymnastics',
  'sport|hockey',
  'sport|ice_skating',
  'sport|running',
  'sport|soccer',
  'sport|swimming',
  'sport|tennis',
  'sport|volleyball',
};

final hikingTags = <String>{
  'highway|bridleway',
  'highway|footway',
  'highway|path',
  'highway|pedestrian',
  'highway|steps',
  'highway|trailhead',
  'highway|via_ferrata',

  'route|foot',
  'route|hiking',

  'amenity|bench',
  'amenity|drinking_water',
  'amenity|shelter',

  'information|guidepost',
  'information|map',
};

final parkingTags = <String>{
  'amenity|parking',
  'amenity|parking_entrance',
  'amenity|parking_meter',
  'amenity|parking_space',
  'amenity|motorcycle_parking',
  'building|parking',
};

final transportTags = <String>{
  // Trasporto pubblico
  'amenity|bus_station',
  'amenity|ferry_terminal',
  'amenity|taxi',
  'highway|bus_stop',
  'public_transport|platform',
  'public_transport|station',
  'public_transport|stop_area',
  'public_transport|stop_position',

  // Ferrovia
  'railway|halt',
  'railway|station',
  'railway|subway_entrance',
  'railway|tram_stop',
  'railway|tram_station',

  // Aeroporti e aviazione
  'aeroway|aerodrome',
  'aeroway|airport',
  'aeroway|helipad',
  'aeroway|terminal',

  // Impianti di risalita
  'aerialway|cable_car',
  'aerialway|chair_lift',
  'aerialway|gondola',
  'aerialway|lift',
  'aerialway|station',

  // Biciclette e imbarcazioni
  'amenity|bicycle_parking',
  'amenity|bicycle_rental',
  'amenity|bicycle_repair_station',
  'amenity|boat_rental',
  'leisure|marina',
  'waterway|dock',
};

final shoppingTags = <String>{
  'amenity|marketplace',

  'shop|alcohol',
  'shop|beauty',
  'shop|books',
  'shop|boutique',
  'shop|clothes',
  'shop|department_store',
  'shop|fashion',
  'shop|gift',
  'shop|hairdresser',
  'shop|jewelry',
  'shop|kiosk',
  'shop|mall',
  'shop|mobile_phone',
  'shop|shoes',
  'shop|sports',
  'shop|supermarket',
  'shop|toys',
  'shop|travel_agency',
  'shop|variety_store',

  'craft|ceramics',
  'craft|glassblower',
  'craft|jeweller',
  'craft|pottery',
  'craft|shoemaker',
  'craft|tailor',
  'craft|watchmaker',
};

final natureTags = <String>{
  'landuse|forest',
  'landuse|meadow',
  'landuse|orchard',
  'landuse|recreation_ground',
  'landuse|vineyard',

  'leisure|garden',
  'leisure|nature_reserve',
  'leisure|park',
  'leisure|playground',

  'natural|beach',
  'natural|fell',
  'natural|grassland',
  'natural|heath',
  'natural|scrub',
  'natural|shrubbery',
  'natural|tree',
  'natural|tree_row',
  'natural|wood',
};

final mountainTags = <String>{
  'natural|arete',
  'natural|cliff',
  'natural|cave_entrance',
  'natural|peak',
  'natural|ridge',
  'natural|saddle',
  'natural|scree',
  'natural|sinkhole',
  'natural|valley',
  'natural|volcano',

  'piste|downhill',
  'piste|nordic',
  'piste|ski_jump',
  'piste|sled',
  'piste|skitour',

  'sport|skiing',
  'sport|snowboard',
};

final waterTags = <String>{
  'natural|bay',
  'natural|coastline',
  'natural|glacier',
  'natural|lake',
  'natural|spring',
  'natural|water',
  'natural|wetland',

  'place|ocean',
  'place|sea',

  'water|basin',
  'water|canal',
  'water|lake',
  'water|lagoon',
  'water|pond',
  'water|reservoir',
  'water|river',
  'water|stream',
  'water|wetland',

  'waterway|canal',
  'waterway|dam',
  'waterway|ditch',
  'waterway|drain',
  'waterway|river',
  'waterway|stream',
  'waterway|waterfall',
  'waterway|weir',
};

final cityTags = <String>{
  'place|allotments',
  'place|borough',
  'place|city',
  'place|hamlet',
  'place|isolated_dwelling',
  'place|neighbourhood',
  'place|quarter',
  'place|suburb',
  'place|town',
  'place|village',
};

final countryTags = <String>{'place|country'};

final geoAreaTags = <String>{
  'place|continent',
  'place|archipelago',
  'place|island',
  'place|islet',
  'place|state',
  'place|region',
  'place|province',
  'place|district',
  'place|county',
  'place|municipality',
  'place|department',
  'place|prefecture',
};

PoiCategory mapPoiCategory(String osmKey, String osmType) {
  final value = '$osmKey|$osmType';

  if (countryTags.contains(value)) {
    return PoiCategory.country;
  }

  if (geoAreaTags.contains(value)) {
    return PoiCategory.geoarea;
  }

  if (foodTags.contains(value)) {
    return PoiCategory.food;
  }

  if (accommodationTags.contains(value)) {
    return PoiCategory.accommodation;
  }

  if (religionTags.contains(value)) {
    return PoiCategory.religion;
  }

  if (historicTags.contains(value)) {
    return PoiCategory.historic;
  }

  if (cultureTags.contains(value)) {
    return PoiCategory.culture;
  }

  if (tourismTags.contains(value)) {
    return PoiCategory.tourism;
  }

  if (shoppingTags.contains(value)) {
    return PoiCategory.shopping;
  }

  if (hikingTags.contains(value)) {
    return PoiCategory.hiking;
  }

  if (sportTags.contains(value)) {
    return PoiCategory.sport;
  }

  if (parkingTags.contains(value)) {
    return PoiCategory.parking;
  }

  if (transportTags.contains(value)) {
    return PoiCategory.transport;
  }

  if (mountainTags.contains(value)) {
    return PoiCategory.mountain;
  }

  if (waterTags.contains(value)) {
    return PoiCategory.water;
  }

  if (natureTags.contains(value)) {
    return PoiCategory.nature;
  }

  if (cityTags.contains(value)) {
    return PoiCategory.city;
  }

  return PoiCategory.other;
}
