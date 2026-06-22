import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:myplaces/shared/widgets/circled_emoji.dart';
import 'package:myplaces/shared/widgets/layout/secondary_titled_screen.dart';
import 'package:myplaces/shared/widgets/map/map_view_card.dart';

import '../../../core/constants/AppLayout.dart';
import '../../../shared/widgets/app_search_bar.dart';
import '../models/collection.dart';

class CollectionDetailScreen extends StatelessWidget {
  final Collection collection;

  const CollectionDetailScreen({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    MapController controller = MapController();

    return SecondaryTitledScreen(
      title: collection.name,
      subtitle: "${collection.pois.length} places saved",
      searchBar: GenericSearchBar(hintText: 'Cerca luoghi...', onSearch: (query) {}),
      action: CircledEmoji(collection: collection),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: AppLayout.getMediumVerticalSpace(context),
        children: [
          MapViewCard(controller: controller, markerBuilder: () => []),
          Text("Places", style: Theme.of(context).textTheme.titleMedium),
          GridView.builder(
            shrinkWrap: true,
            // Necessario dentro una Column
            physics: const NeverScrollableScrollPhysics(),
            // La Column è dentro uno scroll di sistema
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppLayout.getSmallHorizontalSpace(context),
              mainAxisSpacing: AppLayout.getSmallVerticalSpace(context),
              childAspectRatio: 1.4, // Aspect ratio tipico delle card in foto
            ),
            itemCount: collection.pois.length,
            itemBuilder: (context, index) {
              final poi = collection.pois[index];
              return Container(height: 5, color: Colors.red, child: Text(poi.name));
            },
          ),
        ],
      ),
    );
  }
}
