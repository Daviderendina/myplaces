import 'package:myplaces/src/domain/my_list.dart';
import 'package:myplaces/logger.dart';

import '../domain/poi.dart';
import '../data/list_repository.dart';

class ListService {
  final ListRepository _service;

  ListService(this._service);

  List<MyList> getAll() => _service.getAllLists();

  List<MyList> getAllDefault() {
    // TODO usare questi metodi di logica!! non metterla nella UI, se domani cambia il flag???
    return getAll().where((l) => l.isDefault).toList();
  }

  Future<MyList?> getById(int id) => _service.getById(id);

  Future<MyList> save(MyList myList) async {
    logger.info('Saving MyList: $myList');

    MyList? myListSaved = await getById(myList.id);

    if (myListSaved != null) {
      myList.id = myListSaved.id;
    }

    bool nameAlreadyExists = myListSaved == null && listExists(myList);
    if (nameAlreadyExists) {
      logger.warn('Cannot save MyList: name "${myList.name}" already exists');
      return Future.error("Name is already present");
    }

    MyList result = await _service.save(myList);
    logger.info('MyList saved, result: $result');
    return result;
  }

  void delete(MyList myList) => _service.deleteList(myList);

  bool listExists(MyList myList) {
    return _service.getListByName(myList.name) != null;
  }
}
