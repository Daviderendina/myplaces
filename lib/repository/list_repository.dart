import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/service/list_service.dart';

import '../models/poi.dart';

class ListRepository {
  final ListService _service;

  ListRepository(this._service);

  List<MyList> getAll() => _service.getAllLists();

  Future<MyList> save(MyList myList) => _service.save(myList);

  void delete(MyList myList) => _service.deleteList(myList);
}
