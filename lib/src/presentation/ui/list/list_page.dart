import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:myplaces/components/list_page/poi_card.dart';
import 'package:myplaces/extension/title_case_extension.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/models/poi_image.dart';
import 'package:myplaces/src/presentation/ui/poi_detail/poi_detail_page.dart';
import 'package:myplaces/providers.dart';

import '../../../../components/common/main_page_title.dart';
import '../../../../models/poi.dart';
import '../common/chips.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myList = ref.watch(selectedListControllerProvider);

    if (myList == null) return SizedBox();

    List<Poi> poiList = myList.poiList;
    TextEditingController textEditingController = TextEditingController();

    // TODO capire qui
    if (myList.note.isNotEmpty) {
      textEditingController.text = myList.note;
    }

    return Scaffold(
      appBar: AppBar(toolbarHeight: 60),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MainPageTitle(text: myList.name.toTitleCase()),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  MyActionChip(
                    title: "Search",
                    icon: Icons.search,
                    onTap: () {},
                  ),

                  const SizedBox(width: 4),
                  MyActionChip(title: "Map", icon: Icons.map, onTap: () {}),

                  if (!myList.isDefault) ...[
                    const SizedBox(width: 4),
                    MyFilterChip(
                      title: myList.isArchived ? 'Hidden' : 'Showed',
                      icon: myList.isArchived
                          ? Icons.visibility_off
                          : Icons.visibility,
                      selected: !myList.isArchived,
                      onSelected: (v) => updateListVisibility(!v, ref),
                      selectedColor: Colors.green,
                    ),
                  ],

                  if (myList.note.isEmpty) ...[
                    const SizedBox(width: 4),
                    MyActionChip(
                      title: "Add note",
                      icon: Icons.playlist_add,
                      onTap: () {},
                    ),
                  ],
                ],
              ),
            ),

            if (myList.note.isNotEmpty) ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity, // tutta la larghezza possibile
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.grey.shade900),
                ),
                child: TextField(
                  controller: textEditingController,
                  decoration: const InputDecoration(
                    hintText: 'Aggiungi una nota..',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (newValue) =>
                      updateListNoteField(newValue, myList, ref),
                  onTapOutside: (event) {
                    updateListNoteField(
                      textEditingController.text,
                      myList,
                      ref,
                    );
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ],

            SizedBox(height: 20),

            Expanded(
              child: poiList.isNotEmpty
                  ? ListView.separated(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: poiList.length,
                      itemBuilder: (BuildContext context, int index) {
                        Poi poi = poiList[index];
                        return PoiCard(
                          poi: poi,
                          onTap: () {
                            ref.read(selectedPoiProvider.notifier).state = poi;
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PoiDetailPage(poi: poi),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 6);
                      },
                    )
                  : Center(child: Text("Empty list")),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateListVisibility(bool value, WidgetRef ref) async {
    await ref
        .read(selectedListControllerProvider.notifier)
        .setListVisibility(value);
    ref.read(listsControllerProvider.notifier).refresh();
  }

  void updateListNoteField(String newValue, MyList myList, WidgetRef ref) {
    myList.note = newValue;
    ref.read(listRepositoryProvider).save(myList);
  }
}
