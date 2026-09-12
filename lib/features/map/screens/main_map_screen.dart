import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/map/providers.dart';
import 'package:myplaces/features/map/screens/widgets/AppMarker.dart';
import 'package:myplaces/features/map/screens/widgets/poi_summary_sheet.dart';
import 'package:myplaces/features/map/screens/widgets/select_visible_lists_button.dart';
import 'package:myplaces/shared/widgets/app_search_bar_container.dart';
import 'package:myplaces/src/presentation/ui/map/map_view.dart';

class MainMapScreen extends ConsumerStatefulWidget {
  const MainMapScreen({super.key});

  @override
  ConsumerState<MainMapScreen> createState() => _MainMapScreenState();
}

class _MainMapScreenState extends ConsumerState<MainMapScreen> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mainMapControllerProvider);
    final mapController = ref.read(mainMapControllerProvider.notifier);

    // Ascolta i cambiamenti di stato per muovere la telecamera
    ref.listen(mainMapControllerProvider, (previous, next) {
      if (next.cameraMoveTarget != null) {
        _mapController.move(
          next.cameraMoveTarget!,
          next.targetZoom ?? 7.0,
          offset: next.targetOffset ?? Offset.zero,
        );
      }
    });

    return Stack(
      children: [
        MapView(
          controller: _mapController,
          initialCenter: const LatLng(44, 12.6),
          initialZoom: 5.55,
          markerBuilder: () => [
            if (mapState.selectedPoi != null)
              AppMarker.selectedPoiMarker(mapState.selectedPoi!, context),
          ],
        ),
        if (mapState.selectedPoi != null)
          Positioned(
            left: AppLayout.geometry.mainPagePadding.left,
            right: AppLayout.geometry.mainPagePadding.right,
            bottom: AppLayout.screenHeight * .10,
            child: PoiSummarySheet(
              poi: mapState.selectedPoi!,
              onCloseClick: () => mapController.clearSelection(),
            ),
          ),

        Positioned(
          top: AppLayout.screenHeight * .05,
          right: 0,
          left: 0,
          child: Padding(
            padding: EdgeInsets.only(
              right: AppLayout.geometry.mainPagePadding.right,
              left: AppLayout.geometry.mainPagePadding.left,
            ),
            child: Row(
              spacing: AppLayout.spaces.horizontalSmall,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: AppSearchBar(
                    height: AppLayout.geometry.itemHeightSmall,
                    readOnly: true,
                    leading: Icon(
                      Icons.search,
                      color: Theme.of(context).hintColor,
                    ),
                    trailing: mapState.selectedPoi != null
                        ? Icon(Icons.close, color: Theme.of(context).hintColor)
                        : null,
                    onTrailingTap: () => mapController.clearSelection(),
                    hintText: 'Search..',
                    onTap: () => mapController.onSearchTap(context),
                  ),
                ),

                SelectVisibleListsButton(
                  size: AppLayout.geometry.itemHeightSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
