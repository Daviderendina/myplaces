import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../models/poi.dart';

class PoiDetailOnMap extends StatelessWidget {
  final Poi poi;

  const PoiDetailOnMap({super.key, required this.poi});

  @override
  Widget build(BuildContext context) {
    bool isSelected = false;

    // TODO spostare di qui quando verranno gestite per bene
    String listName = "Canada";
    IconData listIcon = Icons.landscape;
    bool listSelected = true;

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

          // TODO
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   spacing: 24,
          //   children: DefaultListElement.values.map((element) {
          //     return Container(
          //       decoration: BoxDecoration(
          //         borderRadius: BorderRadius.circular(30),
          //         color: isSelected
          //             ? element.listElement.color
          //             : Colors.grey.shade800,
          //       ),
          //       child: IconButton(
          //         onPressed: () {
          //           print("X");
          //         },
          //         icon: Icon(
          //           element.listElement.icon,
          //           size: 32,
          //           color: isSelected ? Colors.white : Colors.grey.shade700,
          //         ),
          //       ),
          //     );
          //   }).toList(),
          // ),
          SizedBox(height: 18),

          Wrap(
            children: [
              FilterChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white),
                ),
                selected: true,
                showCheckmark: false,
                label: Text(listName),
                avatar: Icon(listIcon),
                onSelected: (value) {},
                selectedColor: Colors.deepPurple,
              ),
              FilterChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white),
                ),
                selected: true,
                showCheckmark: false,
                label: Text(listName),
                avatar: Icon(listIcon),
                onSelected: (value) {},
                selectedColor: Colors.blueAccent,
              ),
              FilterChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white),
                ),
                selected: false,
                showCheckmark: false,
                label: Text(listName),
                avatar: Icon(listIcon),
                onSelected: (value) {},
                selectedColor: Colors.deepPurple,
              ),
              FilterChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white),
                ),
                selected: false,
                showCheckmark: false,
                label: Text(listName),
                avatar: Icon(listIcon),
                onSelected: (value) {},
                selectedColor: Colors.deepPurple,
              ),
              FilterChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white),
                ),
                selected: false,
                showCheckmark: false,
                label: Text(listName),
                avatar: Icon(listIcon),
                onSelected: (value) {},
                selectedColor: Colors.deepPurple,
              ),
              FilterChip(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  side: BorderSide(color: Colors.white),
                ),
                selected: false,
                showCheckmark: false,
                label: Text(listName),
                avatar: Icon(listIcon),
                onSelected: (value) {},
                selectedColor: Colors.deepPurple,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
