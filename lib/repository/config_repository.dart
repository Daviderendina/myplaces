import 'package:myplaces/models/my_list.dart';

class ConfigRepository {
  List<MyList> defaultLists = [
    MyList(name: "Wishlist", isDefault: true),
    MyList(name: "Favourites", isDefault: true),
    MyList(name: "Visited", isDefault: true),
  ];

  List<MyList> getDefaultLists() {
    return defaultLists;
  }
}
