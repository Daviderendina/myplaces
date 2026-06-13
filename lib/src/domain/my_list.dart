import 'package:flutter/material.dart';
import 'package:myplaces/src/domain/default_lists.dart';
import 'package:myplaces/src/domain/poi.dart';
import 'package:myplaces/src/domain/visual_symbol.dart';

import '../tools/extension/title_case_extension.dart';

class MyList {
  int id = 0; 
  String emoji;
  String name;
  bool isDefault;
  String note;
  bool isArchived; 
  bool visibleOnMap;

  IconData? icon;

  final List<Poi> poiList = [];

  MyList({
    required String name,
    this.emoji = '🚩',
    this.isDefault = false,
    this.note = "",
    this.isArchived = false,
    this.visibleOnMap = false,
  }) : name = name.toLowerCase();

  String get displayName => name.toTitleCase();

  void setVisibleOnMap(bool visibleOnMap) => this.visibleOnMap = visibleOnMap;

  void setId(int id) => this.id = id;

  MyList copyWith({
    String? name,
    String? note,
    String? emoji,
    bool? isArchived,
    bool? visibleOnMap,
  }) {
    final copy = MyList(
      name: name ?? this.name,
      isDefault: isDefault,
      note: note ?? this.note,
      emoji: emoji ?? this.emoji,
      isArchived: isArchived ?? this.isArchived,
      visibleOnMap: visibleOnMap ?? this.visibleOnMap,
    );
    copy.id = id;
    copy.poiList.addAll(poiList);

    return copy;
  }

  @override
  String toString() {
    return 'MyList{id: $id, name: "$name", emoji: "$emoji", isDefault: $isDefault, isArchived: $isArchived, visibleOnMap: $visibleOnMap ,note: "$note", poiCount: ${poiList.length}}';
  }

  Map<String, dynamic> toBackupJson() => {
    'id': id,
    'emoji': emoji,
    'name': name,
    'isDefault': isDefault,
    'note': note,
    'isArchived': isArchived,
    'visibleOnMap': visibleOnMap,
  };

  factory MyList.fromBackupJson(Map<String, dynamic> json) {
    final list = MyList(
      name: json['name'] as String,
      emoji: json['emoji'] as String,
      isDefault: json['isDefault'] as bool,
      note: json['note'] as String,
      isArchived: json['isArchived'] as bool,
      visibleOnMap: json['visibleOnMap'] as bool,
    );
    list.id = json['id'] as int;
    return list;
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
