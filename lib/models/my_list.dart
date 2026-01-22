import 'package:myplaces/extension/title_case_extension.dart';
import 'package:myplaces/models/poi.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class MyList {
  int id = 0;
  String name;
  bool isDefault;
  String note;
  bool isArchived; // TODO rinominare in hidden

  @Backlink('lists')
  final ToMany<Poi> poiList = ToMany();

  MyList({
    required String name,
    this.isDefault = false,
    this.note = "",
    this.isArchived = false,
  }) : name = name.toLowerCase();

  String get displayName => name.toTitleCase();

  void setId(int id) {
    this.id = id;
  }

  MyList copyWith({String? name, String? note, bool? isArchived}) {
    final copy = MyList(
      name: name ?? this.name,
      isDefault: isDefault,
      note: note ?? this.note,
      isArchived: isArchived ?? this.isArchived,
    );
    copy.id = id;
    copy.poiList.addAll(poiList);

    return copy;
  }
}
