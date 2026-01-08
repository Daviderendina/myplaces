import 'package:myplaces/models/poi.dart';

import '../objectbox.g.dart';

class PoiService {
  final Box<Poi> _box;

  PoiService(this._box);

  Poi? getById(String id) {
    return _box.query(Poi_.id.equals(id)).build().findFirst();
  }

  void savePoi(Poi poi) async {
    print("Total pois: ${_box.getAll().length}");
    Poi? poiSaved = getById(poi.id);

    if (poiSaved != null) {
      poi.obxId = poiSaved.obxId;
    }
    _box.putAsync(poi);

    // TODO provo a fare un wait per cpaire se il thread `e un altro
  }
}
