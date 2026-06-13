import 'package:myplaces/src/domain/my_list.dart';

class ListRepository {
  List<MyList> getAllLists() {
    return [];
  }

  Future<MyList> save(MyList newList) async {
    return newList;
  }

  Future<MyList?> getById(int id) async {
    return null;
  }

  MyList? getListByName(String name) {
    return null;
  }

  void deleteList(MyList myList) async {
    // nothing to do
  }
}
