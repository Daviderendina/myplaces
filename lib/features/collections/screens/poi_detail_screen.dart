import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/core/models/poi.dart';
import 'package:myplaces/shared/widgets/large_button.dart';
import 'package:myplaces/shared/widgets/carousel/app_image_carousel.dart';
import 'package:myplaces/shared/widgets/icon_text_row.dart';

class PoiDetailScreen extends ConsumerWidget {
  final Poi? poi;

  const PoiDetailScreen({super.key, this.poi});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var height = MediaQuery.sizeOf(context).height;

    final images = [
      'https://picsum.photos/800/600',
      'https://picsum.photos/200',
      'https://picsum.photos/800/600',
      'https://picsum.photos/400/600',
      'https://picsum.photos/800/600',
    ];

    final displayPoi =
        poi ??
        Poi(
          id: "0",
          name: "Cimone di Margno",
          coordinates: const Coordinates(latitude: 45.123, longitude: 9.123),
        );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: AppLayout.getFullscreenModalPadding(context),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 0,
            children: [
              AppImageCarousel(images: images, height: height * 0.45),
              SizedBox(height: AppLayout.space.getVerticalMedium(context)),

              // Name
              Text(
                overflow: TextOverflow.ellipsis,
                displayPoi.name,
                style: Theme.of(context).textTheme.headlineLarge,
              ),

              SizedBox(height: AppLayout.space.getVerticalSmall(context)),

              // Description
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi conLorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi con",
                style: Theme.of(context).textTheme.bodySmall,
              ),

              SizedBox(height: AppLayout.space.getVerticalSmall(context)),

              IconTextRow(
                icon: Icons.location_on_outlined,
                text:
                    "${displayPoi.coordinates.latitude}, ${displayPoi.coordinates.longitude}",
              ),

              // Additional info
              SizedBox(height: AppLayout.space.getVerticalSmall(context)),

              // Notes
              Text("Notes", style: Theme.of(context).textTheme.headlineSmall),
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                "Lorem ipsum dolor sit amet, consectetur adipisci elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua.",
                style: Theme.of(context).textTheme.bodySmall,
              ),

              const Spacer(),
              LargeButton(text: "Add to List", onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
