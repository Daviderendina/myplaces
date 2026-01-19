import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/providers.dart';
import 'package:myplaces/src/presentation/ui/common/poi/poi_button_list.dart';

import '../poi_detail/poi_detail_page.dart';
import '../../../../../models/poi.dart';

class PoiBottomSheet extends ConsumerWidget {
  const PoiBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Poi? poi = ref.watch(selectedPoiController);

    return poi == null
        ? SizedBox()
        : DraggableScrollableSheet(
            initialChildSize: 0.5,
            expand: false,
            builder: (context, scrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  color: Colors.black,
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.black54,
                        padding: EdgeInsets.only(top: 26, left: 33, right: 33),
                        child: Column(
                          spacing: 0,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              poi.name,
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              poi.getDisplayAreaName(),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
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
                                              width: MediaQuery.of(
                                                context,
                                              ).size.width,
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 5.0,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.amber,
                                              ),
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

                            PoiButtonList(),
                            //
                            // AddListDefaultButtons(
                            //   lists: allDefinedLists.where((l) => l.isDefault).toList(),
                            //   poi: poi,
                            // ),
                            //
                            // SizedBox(height: 22),
                            //
                            // AddListCustomChips(
                            //   lists: allDefinedLists.where((l) => !l.isDefault).toList(),
                            //   poi: poi,
                            // ),
                          ],
                        ),
                      ),
                      Positioned(
                        right: 12,
                        top: 12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => PoiDetailPage(poi: poi),
                                ),
                              ),
                              icon: Icon(Icons.fullscreen),
                            ),
                            IconButton(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
