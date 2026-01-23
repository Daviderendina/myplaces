import 'package:myplaces/src/domain/poi_category.dart';

final poiCategoriesMapping = {
  "place|country": PoiCategory.country,

  "place|state": PoiCategory.geoarea,
  "place|region": PoiCategory.geoarea,
  "place|province": PoiCategory.geoarea,
  "place|district": PoiCategory.geoarea,
  "place|county": PoiCategory.geoarea,

  "place|borough": PoiCategory.city,
  "place|suburb": PoiCategory.city,
  "place|quarter": PoiCategory.city,
  "place|neighbourhood": PoiCategory.city,
  "place|city": PoiCategory.city,
  "place|town": PoiCategory.city,
  "place|village": PoiCategory.city,
  "place|hamlet": PoiCategory.city,
  "place|isolated_dwelling": PoiCategory.city,
  "place|allotments": PoiCategory.city,

  "amenity|bar": PoiCategory.food,
  "amenity|biergarten": PoiCategory.food,
  "amenity|cafe": PoiCategory.food,
  "amenity|fast_food": PoiCategory.food,
  "amenity|food_court": PoiCategory.food,
  "amenity|ice_cream": PoiCategory.food,
  "shop|bakery": PoiCategory.food,
  "amenity|pub": PoiCategory.food,
  "amenity|restaurant": PoiCategory.food,
  "craft|bakery": PoiCategory.food,

  "building|stadium": PoiCategory.sport,
  "building|sports_centre": PoiCategory.sport,

  "highway|trailhead": PoiCategory.hiking,
  "highway|via_ferrata": PoiCategory.hiking,
  "route|hiking": PoiCategory.hiking,
  "tourism|alpine_hut": PoiCategory.hiking,
  "tourism|wilderness_hut": PoiCategory.hiking,

  "amenity|parking": PoiCategory.parking,
  "amenity|parking_space": PoiCategory.parking,
  "building|parking": PoiCategory.parking,

  "building|religious": PoiCategory.buildingReligious,
  "building|cathedral": PoiCategory.buildingReligious,
  "building|chapel": PoiCategory.buildingReligious,
  "building|church": PoiCategory.buildingReligious,
  "building|kingdom_hall": PoiCategory.buildingReligious,
  "building|monastery": PoiCategory.buildingReligious,
  "building|mosque": PoiCategory.buildingReligious,
  "building|presbytery": PoiCategory.buildingReligious,
  "building|shrine": PoiCategory.buildingReligious,
  "building|synagogue": PoiCategory.buildingReligious,
  "building|temple": PoiCategory.buildingReligious,
  "amenity|place_of_worship": PoiCategory.buildingReligious,

  "natural|arete": PoiCategory.mountain,
  "natural|peak": PoiCategory.mountain,
  "natural|ridge": PoiCategory.mountain,
  "natural|saddle": PoiCategory.mountain,
  "natural|scree": PoiCategory.mountain,
  "natural|sinkhole": PoiCategory.mountain,
  "natural|valley": PoiCategory.mountain,
  "natural|volcano": PoiCategory.mountain,
  "": PoiCategory.other,
  "": PoiCategory.other,
  "": PoiCategory.other,
  "": PoiCategory.other,
  "": PoiCategory.other,
  "": PoiCategory.other,
  "": PoiCategory.other,
  "": PoiCategory.other,
  "": PoiCategory.other,
  "": PoiCategory.other,

  /*



amenity|library
amenity|arts_centre
amenity|casino
amenity|fountain
amenity|music_venue
amenity|planetarium
amenity|theatre
amenity|courthouse
amenity|townhall
amenity|clock

barrier|city_wall

// Tourism
tourism|aquarium
tourism|artwork
tourism|attraction
tourism|gallery
tourism|museum
tourism|viewpoint
tourism|zoo
tourism|theme_park

// Water
water|*

// Civic / Amenity Buildings
building|clock_tower
building|gatehouse
building|museum
building|public
building|train_station

// Other Buildings / Historic
building|castle
building|pagoda
building|ruins
building|tower
building|triumphal_arch

// Geological
geological|*

route|piste
route|ski

// Historic / Transport
historic|*
public_transport|station

// Nature / Leisure
leisure|garden
leisure|nature_reserve
leisure|park

natural|ne mancanio alcuni

// Man-made
man_made|bridge
man_made|lighthouse
man_made|obelisk
man_made|windmill

place	archipelago		A named group or chain of closely related islands and islets.
place	island	 	Any piece of land that is completely surrounded by water and isolated from other significant landmasses (bigger than 1 km²).
place	islet	 	A very small island (smaller than 1 km²).
place	square	 	A town or village square: a (typically) paved open space, generally of architectural significance, which is surrounded by buildings in a built-up area such as a city, town or village.
place	locality	  	A named place that has no population.
place	polder	 	A land area that forms an artificial hydrological entity enclosed by embankments and usually is under sea level.
place	sea	 	A large body of salt water part of, or connected to, an ocean.
place	ocean		The world's five main major oceanic divisions.
  * */
};
