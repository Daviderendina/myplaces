import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:myplaces/models/poi_image.dart';

import '../models/poi.dart';

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Poi> listsPoi = [];
    for (var i = 0; i < 20; i++) {
      listsPoi.add(randomPoi());
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Preferiti", style: TextStyle(fontSize: 26)),
        toolbarHeight: 80,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.map)),
          IconButton(onPressed: () {}, icon: Icon(Icons.filter_list)),
        ],
      ),
      body: ListView.builder(
        itemCount: listsPoi.length,
        itemBuilder: (BuildContext context, int index) {
          return getPoiCard(listsPoi[index]);
        },
      ),
    );
  }
}

Widget getPoiCard(Poi poi) {
  List<(IconData, String, VoidCallback)> popupMenuItems = [
    (Icons.add, "Add to list", () {}),
    (Icons.pending, "Add to Wishlist", () {}),
    (Icons.favorite, "Add to Favourites", () {}),
    (Icons.check_circle, "Add to Visited", () {}),
    (Icons.delete, "Remove from list", () {}),
  ];

  return Container(
    margin: EdgeInsetsGeometry.all(4),
    child: Material(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Container(
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 70,
                height: 70,
                child: Image.network(
                  poi.images[0].thumbnail ?? "",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          poi.name,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            height: 1.2,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Poppins",
                          ),
                        ),
                        Text(
                          poi.getDisplayAreaName(),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            height: 1.2,
                            fontSize: 14,
                            color: Colors.white70,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Spacer(),
              PopupMenuButton<int>(
                itemBuilder: (context) {
                  return popupMenuItems.map((item) {
                    return PopupMenuItem<int>(
                      onTap: item.$3,
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(item.$1),
                            SizedBox(width: 10),
                            Text(item.$2),
                          ],
                        ),
                      ),
                    );
                  }).toList();
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Poi randomPoi() {
  final _random = Random();
  // Genera id casuale
  String id = _random.nextInt(100000).toString();

  // Nomi fake
  List<String> names = ["Parigi", "Roma", "Londra", "Berlino", "Madrid"];
  List<String> cities = ["Paris", "Rome", "London", "Berlin", "Madrid"];
  List<String> countries = ["France", "Italy", "UK", "Germany", "Spain"];
  List<String> provinces = [
    "Île-de-France",
    "Lazio",
    "Greater London",
    "Berlin",
    "Madrid",
  ];

  int index = _random.nextInt(names.length);

  return Poi(
    id: id,
    name: "${names[index]}-$id",
    city: cities[index],
    country: countries[index],
    province: provinces[index],
    coordinates: LatLng(0, 0),
    // images: [
    //   PoiImage(
    //     thumbnail:
    //         "https://imgs.search.brave.com/hPr3nPUx2qlCXdoc_8ZXBJC3ei91AeVq7CLzkyP3SIc/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9kMWNz/YXJrejhvYmU5dS5j/bG91ZGZyb250Lm5l/dC9wb3N0ZXJwcmV2/aWV3cy9pdGFseS1y/b21lLWZhbW91cy1w/bGFjZS12aWRlby1k/ZXNpZ24tdGVtcGxh/dGUtODExZmNkMWZh/YzJiMGNiZWM5OGRk/YzkzZGQ5YmE0NjZf/c2NyZWVuLmpwZz90/cz0xNjMwOTkzNTE4",
    //     imageUrl: "",
    //   ),
    // ],
  );
}
