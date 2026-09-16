import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/shared/widgets/button/icon_app_button.dart';
import 'package:myplaces/shared/widgets/button/text_app_button.dart';
import 'package:myplaces/shared/widgets/carousel/app_image_carousel.dart';

import '../../../../../core/models/poi.dart';
import '../../../../collections/screens/select_collection_modal.dart';
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
            // images: widget.poi.images
            //     .map((i) => i.imageUrl ?? '')
            //     .toList(),
            images: [
              'https://picsum.photos/800/600',
              'https://picsum.photos/200',
              'https://picsum.photos/800/600',
              'https://picsum.photos/400/600',
              'https://picsum.photos/800/600',
            ],
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
          Text(
            "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi conLorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi con",
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
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
