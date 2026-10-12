import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/core/models/poi.dart';
import 'package:myplaces/features/collections/screens/select_collection_modal.dart';
import 'package:myplaces/features/poi/screens/widgets/label/info_poi_label.dart';
import 'package:myplaces/features/poi/screens/widgets/label/location_poi_label.dart';
import 'package:myplaces/features/poi/screens/widgets/label/saved_poi_label.dart';
import 'package:myplaces/features/poi/screens/widgets/label/visited_poi_label.dart';
import 'package:myplaces/shared/widgets/button/text_app_button.dart';
import 'package:myplaces/shared/widgets/carousel/app_image_carousel.dart';
import 'package:myplaces/shared/widgets/elevated_container.dart';

import '../../../shared/widgets/button/transparent_back_button.dart';

class PoiDetailScreen extends ConsumerWidget {
  final Poi poi;

  const PoiDetailScreen({super.key, required this.poi});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      body: Padding(
        padding: AppLayout.geometry.untitledMainPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 0,
          children: [
            AppImageCarousel(
              images: poi.imageList,
              height: height * 0.45,
              overlay: TransparentBackButton(),
            ),
            SizedBox(height: AppLayout.spaces.verticalLarge),

            // Name
            Text(
              poi.name,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: AppLayout.spaces.verticalSmall),

            // Category
            Text(poi.category.name, style: Theme.of(context).textTheme.displaySmall),
            SizedBox(height: AppLayout.spaces.verticalSmall),

            // Location label
            LocationPoiLabel(poi: poi),
            SizedBox(height: AppLayout.spaces.verticalSmall),

            // Info box
            ElevatedContainer(
              child: Column(
                children: [
                  VisitedPoiLabel(poi: poi),
                  SavedPoiLabel(poi: poi),
                ],
              ),
            ),

            // Description
            Column(
              children: [
                if (poi.address?.street != null)
                  InfoPoiLabel(icon: Icons.pin_drop_rounded, text: "${poi.address!.street}"),
              ],
            ),
            SizedBox(height: AppLayout.spaces.verticalMedium),

            // Notes
            Text("My notes", style: Theme.of(context).textTheme.headlineSmall),
            SizedBox(height: AppLayout.spaces.verticalSmall),
            ElevatedContainer(
              child: Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),

            const Spacer(),
            TextAppButton(
              text: "Add to Collection",
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => SelectCollectionModal(
                    title: 'Salva in una collezione',
                    initialCollectionIds: poi.collectionsBelonged.map((c) => c.id).toList(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
