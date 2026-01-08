import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:myplaces/components/list_page/poi_card.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/models/poi_image.dart';

import '../models/poi.dart';

class ListPage extends StatelessWidget {
  final MyList myList;

  ListPage({super.key, required this.myList});

  @override
  Widget build(BuildContext context) {
    List<Poi> poiList = myList.poiList;

    return Scaffold(
      appBar: AppBar(
        title: Text(myList.displayName, style: TextStyle(fontSize: 26)),
        toolbarHeight: 80,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.map)),
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
        ],
      ),
      body: poiList.isNotEmpty
          ? ListView.builder(
              itemCount: poiList.length,
              itemBuilder: (BuildContext context, int index) {
                return PoiCard(poi: poiList[index]);
              },
            )
          : Center(child: Text("Empty list")),
    );
  }
}
