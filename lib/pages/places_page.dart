import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myplaces/components/list_circle_card.dart';
import 'package:myplaces/components/page_title.dart';
import 'package:myplaces/models/default_list_element.dart';

import '../components/page_subtitle.dart';

class PlacesPage extends StatelessWidget {
  final List<DefaultListElement> items = [
    DefaultListElement.favourites,
    DefaultListElement.todo,
    DefaultListElement.visited,
    DefaultListElement.favourites,
    DefaultListElement.todo,
    DefaultListElement.favourites,
    DefaultListElement.todo,
    DefaultListElement.visited,
    DefaultListElement.favourites,
    DefaultListElement.todo,
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60),
          PageTitle(text: "Places"),
          SizedBox(height: 20),

          // Default places
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListCircleCard(
                listElement: DefaultListElement.todo,
                placesNumber: 4,
              ),
              ListCircleCard(
                listElement: DefaultListElement.favourites,
                placesNumber: 56,
              ),
              ListCircleCard(
                listElement: DefaultListElement.visited,
                placesNumber: 5,
              ),
            ],
          ),

          SizedBox(height: 30),
          PageSubtitle(text: "My Lists"),
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: items
                  .map((item) => UserListRow(listElement: item))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class UserListRow extends StatelessWidget {
  final DefaultListElement listElement;

  const UserListRow({super.key, required this.listElement});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(21),
        onTap: () {
          print("Hai cliccato sull'elemento!");
        },
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: listElement.color,
                shape: BoxShape.circle,
              ),
              child: Icon(listElement.icon, color: Colors.white, size: 26),
            ),
            SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  listElement.label,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: "Poppins",
                  ),
                ),
                Text(
                  "5 luoghi - ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete),
              padding: EdgeInsets.all(0),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
              padding: EdgeInsets.all(0),
            ),
          ],
        ),
      ),
    );
  }
}
