import 'package:flutter/material.dart';
import 'package:myplaces/pages/list_page.dart';

import '../models/list_element.dart';

class ListRowCard extends StatelessWidget {
  final PlacesList listElement;

  const ListRowCard({super.key, required this.listElement});

  @override
  Widget build(BuildContext context) {
    List<(IconData, String, VoidCallback)> popupMenuItems = [
      (Icons.edit, "Edit", () {}),
      (Icons.delete, "Delete", () {}),
    ];

    return Container(
      margin: EdgeInsetsGeometry.all(4),
      child: Material(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => ListPage()));
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Icon(
                    listElement.icon,
                    color: listElement.color.withAlpha(250),
                    size: 34,
                  ),
                ),
                SizedBox(width: 14),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      listElement.label,
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
                      "5 luoghi", // TODO
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
}
