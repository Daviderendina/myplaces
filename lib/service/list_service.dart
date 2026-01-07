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
    // TODO controllare se non esiste gia`
    await _box.putAsync(newList);
    return newList;
  }
}
