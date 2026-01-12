import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/my_list.dart';
import '../../../models/poi.dart';
import '../../../providers.dart';

class AddListCustomChips extends ConsumerStatefulWidget {
  final List<MyList> lists;
  final Poi poi;

  const AddListCustomChips({super.key, required this.lists, required this.poi});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      AddListCustomChipsState();
}

class AddListCustomChipsState extends ConsumerState<AddListCustomChips> {
  @override
  Widget build(BuildContext context) {
    List<int> poiListsId = widget.poi.lists.map((l) => l.id).toList();

    return Wrap(
      spacing: 5,
      children: widget.lists.map((myList) {
        bool selected = poiListsId.contains(myList.id);

        return FilterChip(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
            side: BorderSide(
              color: selected
                  ? Color(0xFFA7644E).withAlpha(40)
                  : Colors.transparent,
            ),
          ),
          backgroundColor: Colors.black45,
          selected: selected,
          showCheckmark: false,
          label: Text(
            myList.name,
            style: TextStyle(
              color: selected
                  ? Color(0xFFA7644E).withAlpha(255)
                  : Colors.grey[800],
            ),
          ),
          avatar: Icon(
            Icons.question_mark,
            color: selected
                ? Color(0xFFA7644E).withAlpha(255)
                : Colors.grey[800],
          ),
          onSelected: (value) => onListClick(selected, widget.poi, myList),
          selectedColor: Color(0xFFA7644E).withAlpha(50),
        );
      }).toList(),
    );
  }

  // TODO fare unico
  void onListClick(bool selected, Poi poi, MyList myList) {
    print("onListClick >>> ${poi.lists}");
    setState(() {
      if (selected) {
        print("REMM");
        poi.lists.removeWhere((l) => l.id == myList.id);
      } else {
        print("ADDD");
        poi.addToList(myList);
      }
    });

    ref.read(poiRepositoryProvider).save(poi);
    ref.read(savedPageProvider.notifier).refresh();
  }
}
