import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/service/list_service.dart';

class ListRepository {
  final ListService _service;

  ListRepository(this._service);

  List<MyList> getAll() => _service.getAllLists();

  Future<MyList> add(MyList myList) => _service.addList(myList);
}
