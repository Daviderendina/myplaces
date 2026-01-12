import 'package:flutter/material.dart';

import '../../models/poi.dart';

class PoiCard extends StatelessWidget {
  final Poi poi;
  final VoidCallback onTap;

  const PoiCard({super.key, required this.poi, required this.onTap});

  @override
  Widget build(BuildContext context) {
    List<(IconData, String, VoidCallback)> popupMenuItems = [
      // (Icons.add, "Add to list", () {}),
      (Icons.pending, "Add to Wishlist", () {}),
      (Icons.favorite, "Add to Favourites", () {}),
      (Icons.check_circle, "Add to Visited", () {}),
      (Icons.delete, "Remove from list", () {}),
    ];

    return Container(
      child: Material(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: SizedBox(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: Image.network(
                    poi.images.isNotEmpty ? poi.images[0].thumbnail ?? "" : "",
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
                              fontSize: 19,
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
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Icon(item.$1),
                            SizedBox(width: 10),
                            Text(item.$2),
                          ],
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
