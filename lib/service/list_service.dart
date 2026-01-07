import 'package:myplaces/models/my_list.dart';

import '../objectbox.g.dart';

class ListService {
  final Box<MyList> _box;

  ListService(this._box);

  List<MyList> getAllLists() {
    print('MyList count: ${_box.count()}');
    return _box.getAll();
  }

  Future<MyList> addList(MyList newList) async {
    print("Creating new list");

    newList.name = newList.name.toLowerCase();

    final existing = getListByName(newList.name);
    if (existing != null) {
      return Future.error("Name is already present");
    }

    final id = await _box.putAsync(newList);
    newList.setId(id);
    return newList;
  }

  MyList? getListByName(String name) {
    String nameLower = name.toLowerCase();
    final query = _box.query(MyList_.name.equals(nameLower)).build();
    final result = query.findFirst();
    print("RESULT / $result");
    query.close();
    return result;
  }

  void deleteList(MyList myList) async {
    _box.remove(myList.id);
  }
}
