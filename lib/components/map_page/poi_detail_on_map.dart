import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/providers.dart';

import '../../models/my_list.dart';
import '../../models/poi.dart';

class PoiDetailOnMap extends ConsumerWidget {
  // TODO quando carico questo devo vedere prima se `e presente nel DB e comportarmi di conseguenza
  final Poi poi;

  const PoiDetailOnMap({super.key, required this.poi});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MyList> allDefinedLists = ref.read(myListRepositoryProvider).getAll();

    // TODO spostare di qui quando verranno gestite per bene
    String listName = "Canada";
    IconData listIcon = Icons.landscape;

    Color whiteColor = Colors.white.withAlpha(190);

    return Container(
      color: Colors.black,
      padding: EdgeInsets.only(top: 26, left: 33, right: 33),
      // altezza della sheet
      child: Column(
        spacing: 0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //IconButton(onPressed: () {}, icon: Icon(Icons.close)),
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

          SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24,
            children: allDefinedLists.where((l) => l.isDefault).map((myList) {
              bool selected = myList.name == "visited";
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: selected
                          ? Colors.teal
                          : Theme.of(context).colorScheme.surface,
                    ),
                    child: IconButton(
                      onPressed: () {
                        print("X");
                      },
                      icon: Icon(
                        Icons.question_mark, //TODO myList.listElement.icon,
                        size: 30,
                        color: selected ? whiteColor : Colors.grey.shade800,
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
              );
            }).toList(),
          ),
          SizedBox(height: 18),

          Wrap(
            spacing: 5,
            children: allDefinedLists.where((l) => !l.isDefault).map((myList) {
              bool selected = myList.name.length == 1 ? true : false;
              return FilterChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.transparent),
                ),
                selected: selected,
                showCheckmark: false,
                label: Text(
                  myList.name,
                  style: TextStyle(
                    color: selected ? whiteColor : Colors.grey.shade800,
                  ),
                ),
                avatar: Icon(
                  Icons.question_mark,
                  color: selected ? whiteColor : Colors.grey.shade800,
                ),
                onSelected: (value) {},
                selectedColor: Colors.teal.shade600,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
