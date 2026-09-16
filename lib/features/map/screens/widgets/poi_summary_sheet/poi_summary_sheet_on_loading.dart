import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/shared/widgets/button/icon_app_button.dart';
import 'package:myplaces/shared/widgets/skeleton/skeleton_box.dart';

import 'poi_summary_sheet_container.dart';

/// Bottom sheet mostrato mentre il dettaglio del POI è in caricamento:
/// riproduce il layout di [PoiSummarySheet] con placeholder animati.
class PoiSummarySheetOnLoading extends StatelessWidget {
  final VoidCallback? onCloseClick;

  const PoiSummarySheetOnLoading({super.key, this.onCloseClick});

  @override
  Widget build(BuildContext context) {
    return PoiSummarySheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SkeletonBox(
                width: double.infinity,
                height: AppLayout.screenHeight * .25,
                borderRadius: BorderRadius.circular(18),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: IconAppButton.surfaceTransparent(
                  onPressed: onCloseClick ?? () {},
                  icon: Icons.close,
                  buttonSize: AppLayout.buttons.circularSmall,
                  iconSize: AppLayout.icons.small,
                ),
              ),
            ],
          ),
          SizedBox(height: AppLayout.spaces.verticalMedium),
          SkeletonBox(width: AppLayout.screenWidth * .5, height: 24),
          SizedBox(height: AppLayout.spaces.verticalSmall),
          SkeletonBox(width: double.infinity, height: 14),
          SizedBox(height: AppLayout.spaces.verticalSmall),
          SkeletonBox(width: double.infinity, height: 14),
          SizedBox(height: AppLayout.spaces.verticalSmall),
          SkeletonBox(width: AppLayout.screenWidth * .7, height: 14),
          SizedBox(height: AppLayout.spaces.verticalMedium),
          Row(
            spacing: AppLayout.spaces.horizontalXSmall,
            children: [
              Expanded(child: SkeletonBox(height: AppLayout.buttons.primaryHeight)),
              SkeletonBox(width: 40, height: 40),
            ],
          ),
        ],
      ),
    );
  }
}
