import 'package:myplaces/models/my_list.dart';

import '../objectbox.g.dart';

class ListService {
  final Box<MyList> _box;

  ListService(this._box);

  List<MyList> getAllLists() {
    print('MyList count: ${_box.count()}');
    return _box.getAll();
  }

  Future<MyList> save(MyList newList) async {
    print("Creating new list");
    MyList? myListSaved = getById(newList.id);

    if (myListSaved != null) {
      // Update the existing record
      newList.id = myListSaved.id;
    }

    // Check if the name is duplicate
    bool nameAlreadyExists =
        (myListSaved == null) && (getListByName(newList.name) != null);
    if (nameAlreadyExists) {
      return Future.error("Name is already present");
    }

    final id = await _box.putAsync(newList);
    newList.setId(id);
    return newList;

    // TODO provo a fare un wait per cpaire se il thread `e un altro
  }

  MyList? getById(int id) {
    return _box.query(MyList_.id.equals(id)).build().findFirst();
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
