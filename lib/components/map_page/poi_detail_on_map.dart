import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/components/common/poi_detail/add_list_custom.dart';
import 'package:myplaces/components/common/poi_detail/add_list_default.dart';
import 'package:myplaces/providers.dart';

import '../../models/my_list.dart';
import '../../models/poi.dart';

class PoiDetailOnMap extends ConsumerStatefulWidget {
  // TODO quando carico questo devo vedere prima se `e presente nel DB e comportarmi di conseguenza
  final Poi poi;

  const PoiDetailOnMap({super.key, required this.poi});

  @override
  ConsumerState<PoiDetailOnMap> createState() => PoiDetailOnMapState();
}

class PoiDetailOnMapState extends ConsumerState<PoiDetailOnMap> {
  @override
  Widget build(BuildContext context) {
    List<MyList> allDefinedLists = ref.read(myListRepositoryProvider).getAll();
    Poi poi = widget.poi;

    return Container(
      color: Colors.black54,
      padding: EdgeInsets.only(top: 26, left: 33, right: 33),
      child: Column(
        spacing: 0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            poi.name,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          ),
          Text(
            poi.getDisplayAreaName(),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),

          SizedBox(height: 20),

          Container(
            width: double.infinity,
            height: 180,
            color: Colors.grey.shade800,
            child: (poi.images.isEmpty)
                ? Center(child: Icon(Icons.not_interested))
                : CarouselSlider(
                    options: CarouselOptions(
                      enableInfiniteScroll: false,
                      pageSnapping: true,
                      viewportFraction: 1.0,
                    ),
                    items: poi.images.map((poiImage) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(color: Colors.amber),
                            child: Image.network(
                              poiImage.thumbnail ?? "",
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
          ),

          SizedBox(height: 28),

          AddListDefaultButtons(
            lists: allDefinedLists.where((l) => l.isDefault).toList(),
            poi: poi,
          ),

          SizedBox(height: 22),

          AddListCustomChips(
            lists: allDefinedLists.where((l) => !l.isDefault).toList(),
            poi: poi,
          ),
        ],
      ),
    );
  }

  void onListClick(bool selected, Poi poi, MyList myList) {
    print("onListClick >>>");
    setState(() {
      if (selected) {
        poi.lists.removeWhere((l) => l.id == myList.id);
      } else {
        poi.lists.add(myList);
      }
    });

    ref.read(poiRepositoryProvider).save(poi);
    ref.read(savedPageProvider.notifier).refresh();
  }
}
