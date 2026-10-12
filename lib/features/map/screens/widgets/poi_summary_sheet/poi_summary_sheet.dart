import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/core/extensions/StringExtensions.dart';
import 'package:myplaces/shared/widgets/button/icon_app_button.dart';
import 'package:myplaces/shared/widgets/button/text_app_button.dart';
import 'package:myplaces/shared/widgets/carousel/app_image_carousel.dart';

import '../../../../../core/models/poi.dart';
import '../../../../collections/screens/select_collection_modal.dart';
import '../../../../poi/screens/widgets/label/location_poi_label.dart';
import '../../../../poi/screens/widgets/label/saved_poi_label.dart';
import '../../../../poi/screens/widgets/label/visited_poi_label.dart';
import 'poi_summary_sheet_container.dart';

/// Bottom sheet con il dettaglio completo di un [Poi] già caricato.
class PoiSummarySheet extends StatelessWidget {
  final Poi poi;
  final VoidCallback? onCloseClick;

  const PoiSummarySheet({super.key, required this.poi, this.onCloseClick});

  @override
  Widget build(BuildContext context) {
    return PoiSummarySheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImageCarousel(
            images: poi.imageList,
            overlay: IconAppButton.surfaceTransparent(
              onPressed: onCloseClick ?? () {},
              icon: Icons.close,
              buttonSize: AppLayout.buttons.circularSmall,
              iconSize: AppLayout.icons.small,
            ),
            overlayAlignment: Alignment.topRight,
            height: AppLayout.screenHeight * .25,
          ),

          SizedBox(height: AppLayout.spaces.verticalMedium),
          Text(poi.name, style: Theme.of(context).textTheme.displaySmall),

          SizedBox(height: AppLayout.spaces.verticalSmall),
          Row(
            spacing: AppLayout.spaces.horizontalXSmall,
            children: [
              LocationPoiLabel(poi: poi),
              Text("·", style: Theme.of(context).textTheme.bodySmall, maxLines: 1),
              Text(
                poi.category.name.toTitleCase(),
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
              ),
            ],
          ),

          SizedBox(height: AppLayout.spaces.verticalSmall),

          if (poi.collectionsBelonged.isNotEmpty) SavedPoiLabel(poi: poi),

          if (poi.tripsBelonged.isNotEmpty) VisitedPoiLabel(poi: poi),

          //if (poi.tripsBelonged.isEmpty)
          SizedBox(height: AppLayout.spaces.verticalMedium),

          Row(
            spacing: AppLayout.spaces.horizontalXSmall,
            children: [
              Expanded(
                child: TextAppButton.alternative(
                  text: "Add to list",
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => const SelectCollectionModal(
                      title: 'Salva in una collezione',
                      initialCollectionIds: ["1", "3"], // Pass appropriate IDs here
                    ),
                  ),
                ),
              ),
              IconAppButton.primary(
                onPressed: () => context.push('/poi-detail', extra: poi),
                icon: Icons.open_in_new,
                buttonSize: 40,
                shape: IconAppShape.square,
                iconSize: AppLayout.icons.medium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
