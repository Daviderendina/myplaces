import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/models/my_list.dart';

import '../../../models/poi.dart';
import '../../../providers.dart';

class AddListDefaultButtons extends ConsumerStatefulWidget {
  final List<MyList> lists;
  final Poi poi;

  const AddListDefaultButtons({
    super.key,
    required this.lists,
    required this.poi,
  });

  @override
  ConsumerState<AddListDefaultButtons> createState() =>
      AddListDefaultButtonsState();
}

class AddListDefaultButtonsState extends ConsumerState<AddListDefaultButtons> {
  @override
  Widget build(BuildContext context) {
    Color whiteColor = Colors.white.withAlpha(200); //TODO spostare da qua
    List<int> poiListsId = widget.poi.lists.map((l) => l.id).toList();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.lists.map((myList) {
        bool selected = poiListsId.contains(myList.id);

        ref.read(myListRepositoryProvider).getAll();

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite, color: Colors.red, size: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_outline, size: 30),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.favorite_outline, size: 30),
            ),
            SizedBox(width: 15),
            ActionChip(
              label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Add to list",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                ),
              ),
              avatar: Icon(Icons.add),
              onPressed: () {},
              elevation: 0,
              pressElevation: 0,
              shape: const StadiumBorder(side: BorderSide(color: Colors.white)),
              padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
            ),
          ],
        );

        return Container(
          width: 90,
          child: Column(
            children: [
              Container(
                width: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: selected
                      ? Colors.teal
                      : Theme.of(context).colorScheme.surface,
                ),
                child: IconButton(
                  onPressed: () => onListClick(selected, widget.poi, myList),
                  icon: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      Icons.question_mark,
                      size: 30,
                      color: selected ? whiteColor : Colors.grey.shade800,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 4),

              Text(
                myList.displayName,
                style: TextStyle(
                  color: selected ? whiteColor : Colors.grey.shade800,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // TODO fare unico
  void onListClick(bool selected, Poi poi, MyList myList) {
    // print("onListClick >>> ${poi.lists}");
    // setState(() {
    //   if (selected) {
    //     poi.lists.removeWhere((l) => l.id == myList.id);
    //   } else {
    //     poi.addToList(myList);
    //   }
    // });
    //
    // ref.read(poiRepositoryProvider).save(poi);
    // ref.read(savedPageProvider.notifier).refresh();
  }
}
