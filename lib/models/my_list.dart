import 'package:myplaces/models/poi.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MyList {
  int id = 0;
  String name;
  bool isDefault;

  @Backlink('lists')
  final ToMany<Poi> poiList = ToMany();

  MyList({required this.name, this.isDefault = false});
}
