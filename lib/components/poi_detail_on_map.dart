import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/default_list_element.dart';

class PoiDetailOnMap extends StatelessWidget {
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
            "Roma",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
          ),
          Text(
            "Lazio, Italy",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),

          SizedBox(height: 20),

          CarouselSlider(
            options: CarouselOptions(
              height: 180.0,
              enableInfiniteScroll: false,
              pageSnapping: true,
              viewportFraction: 1.0,
            ),
            items:
                [
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/La_chiesetta_votiva_degli_Alpini_nel_paesaggio_autunnale.jpg/960px-La_chiesetta_votiva_degli_Alpini_nel_paesaggio_autunnale.jpg",
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/La_chiesetta_votiva_degli_Alpini_nel_paesaggio_autunnale.jpg/960px-La_chiesetta_votiva_degli_Alpini_nel_paesaggio_autunnale.jpg",
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/La_chiesetta_votiva_degli_Alpini_nel_paesaggio_autunnale.jpg/960px-La_chiesetta_votiva_degli_Alpini_nel_paesaggio_autunnale.jpg",
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/La_chiesetta_votiva_degli_Alpini_nel_paesaggio_autunnale.jpg/960px-La_chiesetta_votiva_degli_Alpini_nel_paesaggio_autunnale.jpg",
                ].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(color: Colors.amber),
                        child: Image.network(
                          i,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      );
                    },
                  );
                }).toList(),
          ),

          SizedBox(height: 24),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 24,
            children: DefaultListElement.values.map((element) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: isSelected
                      ? element.listElement.color
                      : Colors.grey.shade800,
                ),
                child: IconButton(
                  onPressed: () {
                    print("X");
                  },
                  icon: Icon(
                    element.listElement.icon,
                    size: 32,
                    color: isSelected ? Colors.white : Colors.grey.shade700,
                  ),
                ),
              );
            }).toList(),
          ),

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

void test() {}

/*
Container(
          width: 120,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: listElement.color,
                  shape: BoxShape.circle,
                ),
                child: Icon(listElement.icon, color: Colors.white, size: 32),
              ),
              SizedBox(height: 12),
              Text(
                listElement.label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Poppins",
                ),
              ),
              Text(
                "$placesNumber luoghi",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ),
* */
