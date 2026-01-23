import 'package:flutter/material.dart';

import '../../../domain/poi.dart';

class PoiCard extends StatelessWidget {
  final Poi poi;
  final VoidCallback onTap;
  final VoidCallback onDismissed;

  const PoiCard({
    super.key,
    required this.poi,
    required this.onTap,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    // TODO implementare swipe!!!
    return Dismissible(
      key: ValueKey(poi.id),
      direction: DismissDirection.startToEnd,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.red.withAlpha(190),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        onDismissed.call();
      },
      child: ExpansionTile(
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        title: InkWell(
          onTap: onTap,
          child: Container(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xffd39e1d).withAlpha(80),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(poi.category.icon, color: Colors.white, size: 24),
                ),
                SizedBox(width: 14),
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
              ],
            ),
          ),
        ),
        children: [
          SizedBox(
            height: 160,
            width: double.infinity,
            child: SizedBox(
              height: 160,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: poi.images.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final poiImage = poi.images[index];
                  return Container(
                    width: 260,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        poiImage.thumbnail ?? "",
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
