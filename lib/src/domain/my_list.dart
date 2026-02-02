import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myplaces/src/domain/default_lists.dart';
import 'package:myplaces/src/domain/poi.dart';
import 'package:myplaces/src/domain/visual_symbol.dart';
import 'package:objectbox/objectbox.dart';

import '../tools/extension/title_case_extension.dart';

@Entity()
class MyList {
  int id = 0; // TODO rename in obxId
  String emoji;
  String name;
  bool isDefault;
  String note;
  bool isArchived; // TODO rinominare in hidden

  @Transient()
  IconData? icon;

  @Backlink('lists')
  final ToMany<Poi> poiList = ToMany();

  MyList({
    required String name,
    this.emoji = '🚩',
    this.isDefault = false,
    this.note = "",
    this.isArchived = false,
  }) : name = name.toLowerCase();

  String get displayName => name.toTitleCase();

  void setId(int id) {
    this.id = id;
  }

  MyList copyWith({
    String? name,
    String? note,
    String? emoji,
    bool? isArchived,
  }) {
    final copy = MyList(
      name: name ?? this.name,
      isDefault: isDefault,
      note: note ?? this.note,
      emoji: emoji ?? this.emoji,
      isArchived: isArchived ?? this.isArchived,
    );
    copy.id = id;
    copy.poiList.addAll(poiList);

    return copy;
  }
}

extension MyListIconVisualizer on MyList {
  VisualSymbol get visualSymbol {
    if (isDefault) {
      DefaultListType type = DefaultListType.fromName(name);
      return VisualSymbol.icon(type.icon, type.color);
    }
    return VisualSymbol.emoji(emoji);
  }
}
