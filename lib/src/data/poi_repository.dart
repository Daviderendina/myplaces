import 'package:myplaces/src/domain/poi.dart';
import 'package:objectbox/objectbox.dart';

import '../../objectbox.g.dart';

class PoiRepository {
  final Box<Poi> _box;

  PoiRepository(this._box);

  Future<Poi?> getById(String id) async {
    return _box.query(Poi_.id.equals(id)).build().findFirst();
  }

  Future<Poi> savePoi(Poi poi) async {
    int obxId = _box.put(poi);
    poi.setObxId(obxId);
    return Future.value(poi);
  }
}
