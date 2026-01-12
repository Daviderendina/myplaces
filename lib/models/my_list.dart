import 'package:myplaces/models/poi.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MyList {
  int id = 0;
  String name;
  bool isDefault;
  String note;

  @Backlink('lists')
  final ToMany<Poi> poiList = ToMany();

  MyList({required String name, this.isDefault = false, this.note = ""})
    : name = name.toLowerCase();

  String get displayName => name
      .split(' ')
      .map((word) => word[0].toUpperCase() + word.substring(1))
      .join(' ');

  void setId(int id) {
    this.id = id;
  }
}
