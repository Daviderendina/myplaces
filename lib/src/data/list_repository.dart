import 'package:myplaces/src/domain/my_list.dart';
import 'package:myplaces/src/application/list_service.dart';

import '../domain/poi.dart';

class ListService {
  final ListRepository _service;

  ListService(this._service);

  List<MyList> getAll() => _service.getAllLists();

  List<MyList> getAllDefault() {
    // TODO usare questi metodi di logica!! non metterla nella UI, se domani cambia il flag???
    return getAll().where((l) => l.isDefault).toList();
  }

  MyList? getById(int id) => _service.getById(id);

  Future<MyList> save(MyList myList) {
    MyList? myListSaved = getById(myList.id);

    if (myListSaved != null) {
      // Update the existing record
      myList.id = myListSaved.id;
    }

    bool nameAlreadyExists = myListSaved == null && listExists(myList);
    if (nameAlreadyExists) {
      return Future.error("Name is already present");
    }

    return _service.save(myList);
  }

  void delete(MyList myList) => _service.deleteList(myList);

  bool listExists(MyList myList) {
    return _service.getListByName(myList.name) != null;
  }
}
