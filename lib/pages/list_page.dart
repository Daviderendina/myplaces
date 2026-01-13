import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:myplaces/components/list_page/poi_card.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/models/poi_image.dart';
import 'package:myplaces/pages/poi_detail_page.dart';
import 'package:myplaces/providers.dart';

import '../models/poi.dart';

class ListPage extends ConsumerWidget {
  final MyList myList;

  ListPage({super.key, required this.myList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  updateListNoteField(
                    textEditingController.text,
                    myList,
                    ref,
                  );
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
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PoiDetailPage(poi: poi),
                            ),
                          ),
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

  void updateListNoteField(String newValue, MyList myList, WidgetRef ref) {
    myList.note = newValue;
    ref.read(myListRepositoryProvider).save(myList);
  }
}
