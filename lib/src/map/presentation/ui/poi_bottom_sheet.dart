import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/providers.dart';

import '../../../../components/map_page/poi_detail_on_map.dart';
import '../../../../functions/poi_detail_page/poi_detail_page.dart';
import '../../../../models/poi.dart';

class PoiBottomSheet extends ConsumerWidget {
  const PoiBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Poi? poi = ref.watch(selectedPoiController);

    return poi == null
        ? SizedBox()
        : DraggableScrollableSheet(
            initialChildSize: 0.6,
            expand: false,
            builder: (context, scrollController) {
              return ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  color: Colors.black,
                  child: Stack(
                    children: [
                      ListView(
                        controller: scrollController,
                        children: [PoiDetailOnMap(poi: poi)],
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
