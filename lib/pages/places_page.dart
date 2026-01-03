import 'package:flutter/material.dart';
import 'package:myplaces/components/list_circle_card.dart';
import 'package:myplaces/components/page_title.dart';
import 'package:myplaces/models/default_list_element.dart';

import '../components/list_row_card.dart';
import '../components/page_subtitle.dart';

class PlacesPage extends StatelessWidget {
  const PlacesPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                listElement: DefaultListElement.todo.listElement,
                placesNumber: 4,
              ),
              ListCircleCard(
                listElement: DefaultListElement.favourites.listElement,
                placesNumber: 56,
              ),
              ListCircleCard(
                listElement: DefaultListElement.visited.listElement,
                placesNumber: 5,
              ),
            ],
          ),

          SizedBox(height: 30),
          Row(
            children: [
              PageSubtitle(text: "My Lists"),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.add)),
            ],
          ),
          SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              children: items
                  .map((item) => ListRowCard(listElement: item.listElement))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
