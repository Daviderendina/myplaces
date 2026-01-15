import 'package:flutter_riverpod/legacy.dart';
import 'package:myplaces/repository/list_repository.dart';

import '../models/my_list.dart';

class MyListsNotifier extends StateNotifier<List<MyList>> {
  final ListRepository repo;

  MyListsNotifier(this.repo) : super([]) {
    load();
  }

  void load() {
    // Clona la lista per evitare riferimenti diretti
    state = List.from(repo.getAll());
  }

  void refresh() => load();
}
