import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/map/screens/widgets/select_visible_lists_button.dart';
import 'package:myplaces/shared/widgets/app_static_search_bar.dart';
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
    final Size size = MediaQuery.of(context).size;
    final headerHeight = size.height * .05;

    return Stack(
      children: [
        MapView(
          controller: _mapController,
          initialCenter: const LatLng(44, 12.6),
          initialZoom: 5.55,
          markerBuilder: () => [],
        ),
        Positioned(
          top: headerHeight,
          right: 1,
          left: 1,
          child: Row(
            spacing: AppLayout.spaces.horizontalSmall,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppStaticSearchBar(
                width: 230,
                onTap: () {
                  // Future logic
                },
              ),

              SelectVisibleListsButton(),
            ],
          ),
        ),
      ],
    );
  }
}
