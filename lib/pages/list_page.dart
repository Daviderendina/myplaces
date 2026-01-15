import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:myplaces/components/list_page/poi_card.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/models/poi_image.dart';
import 'package:myplaces/functions/poi_detail_page/poi_detail_page.dart';
import 'package:myplaces/providers.dart';

import '../models/poi.dart';

class ListPage extends ConsumerStatefulWidget {
  final MyList myList;

  const ListPage({super.key, required this.myList});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ListPageState();
}

class ListPageState extends ConsumerState<ListPage> {
  @override
  Widget build(BuildContext context) {
    MyList myList = widget.myList;

    List<Poi> poiList = myList.poiList;
    TextEditingController textEditingController = TextEditingController();

    if (myList.note.isNotEmpty) {
      textEditingController.text = myList.note;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(myList.displayName, style: TextStyle(fontSize: 26)),
        toolbarHeight: 80,
        actions: [
          (myList.isArchived)
              ? IconButton(
                  onPressed: () => updateListArchivedField(false, myList, ref),
                  icon: Icon(Icons.visibility),
                )
              : IconButton(
                  onPressed: () => updateListArchivedField(true, myList, ref),
                  icon: Icon(Icons.visibility_off),
                ),
          IconButton(onPressed: () {}, icon: Icon(Icons.map)),
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
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
                  updateListNoteField(textEditingController.text, myList, ref);
                  FocusScope.of(context).unfocus();
                },
              ),
            ),

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

  void updateListArchivedField(bool value, MyList myList, WidgetRef ref) {
    setState(() {
      myList.isArchived = value;
    });
    ref.read(myListRepositoryProvider).save(myList);
  }

  void updateListNoteField(String newValue, MyList myList, WidgetRef ref) {
    myList.note = newValue;
    ref.read(myListRepositoryProvider).save(myList);
  }
}
