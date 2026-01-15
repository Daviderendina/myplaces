import 'package:myplaces/models/poi.dart';
import 'package:objectbox/objectbox.dart';

import '../objectbox.g.dart';

class PoiService {
  final Box<Poi> _box;

  PoiService(this._box);

  Poi? getById(String id) {
    return _box.query(Poi_.id.equals(id)).build().findFirst();
  }

  Future<Poi> savePoi(Poi poi) async {
    Poi? poiSaved = getById(poi.id);

    if (poiSaved != null) {
      poi.obxId = poiSaved.obxId;
    }
    _box.put(poi);

    return Future.value(poi.copy());
  }
}
