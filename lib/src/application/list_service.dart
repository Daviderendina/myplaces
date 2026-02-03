import 'package:myplaces/src/domain/my_list.dart';

import '../../objectbox.g.dart';

class ListRepository {
  final Box<MyList> _box;

  ListRepository(this._box);

  List<MyList> getAllLists() {
    return _box.getAll();
  }

  Future<MyList> save(MyList newList) async {
    final id = await _box.putAsync(newList);
    newList.setId(id);
    return newList;
  }

  Future<MyList?> getById(int id) async {
    return _box.query(MyList_.id.equals(id)).build().findFirst();
  }

  MyList? getListByName(String name) {
    String nameLower = name.toLowerCase();
    final query = _box.query(MyList_.name.equals(nameLower)).build();
    final result = query.findFirst();
    query.close();
    return result;
  }

  void deleteList(MyList myList) async {
    _box.remove(myList.id);
  }
}
