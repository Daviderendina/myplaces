import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/shared/widgets/button/icon_app_button.dart';
import 'package:myplaces/shared/widgets/button/text_app_button.dart';

import 'poi_summary_sheet_container.dart';

/// Bottom sheet mostrato quando il caricamento del dettaglio del POI fallisce.
class PoiSummarySheetOnError extends StatelessWidget {
  final VoidCallback? onCloseClick;
  final VoidCallback? onRetry;

  const PoiSummarySheetOnError({super.key, this.onCloseClick, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return PoiSummarySheetContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconAppButton.surfaceTransparent(
                onPressed: onCloseClick ?? () {},
                icon: Icons.close,
                buttonSize: AppLayout.buttons.circularSmall,
                iconSize: AppLayout.icons.small,
              ),
            ],
          ),
          Text(
            "Non è stato possibile caricare il dettaglio del luogo.",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          SizedBox(height: AppLayout.spaces.verticalMedium),
          TextAppButton.alternative(text: "Riprova", onPressed: onRetry),
        ],
      ),
    );
  }
}
