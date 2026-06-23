import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:myplaces/shared/widgets/circled_emoji.dart';
import 'package:myplaces/shared/widgets/layout/secondary_titled_screen.dart';
import 'package:myplaces/shared/widgets/map/map_view_card.dart';

import '../../../core/constants/AppLayout.dart';
import '../../../shared/widgets/app_search_bar.dart';
import '../models/collection.dart';
import 'widgets/collection_detail_card.dart';

class CollectionDetailScreen extends StatelessWidget {
  final Collection collection;

  const CollectionDetailScreen({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    MapController controller = MapController();

    return SecondaryTitledScreen(
      title: collection.name,
      subtitle: "${collection.pois.length} places saved",
      searchBar: GenericSearchBar(
        // TODO ma serve?
        hintText: 'Cerca luoghi...',
        onSearch: (query) {},
      ),
      action: CircledEmoji(collection: collection),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppLayout.getMediumVerticalSpace(context),
        children: [
          MapViewCard(controller: controller, markerBuilder: () => []),
          Text("Places", style: Theme.of(context).textTheme.titleMedium),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: collection.pois.length,
            separatorBuilder: (context, index) =>
                SizedBox(height: AppLayout.getSmallVerticalSpace(context)),
            itemBuilder: (context, index) {
              final poi = collection.pois[index];
              return CollectionDetailCard(poi: poi);
            },
          ),
        ],
      ),
    );
  }
}
