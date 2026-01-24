import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar_plus/material_floating_search_bar_plus.dart';
import 'package:myplaces/src/presentation/ui/map/poi_result_card.dart';

import '../../../../../src/domain/poi.dart';
import '../../../providers.dart';

class MySearchBar extends ConsumerWidget {
  final FloatingSearchBarController searchBarController;
  final Function(Poi poi) onResultTap;

  const MySearchBar({
    required this.searchBarController,
    required this.onResultTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<List<Poi>> state = ref.watch(searchBarControllerProvider);
    final mapPageState = ref.watch(mapPageControllerProvider);

    return FloatingSearchBar(
      actions: [
        mapPageState.showPoiMarker
            ? IconButton(
                onPressed: () {
                  ref.read(mapPageControllerProvider.notifier).clearMap();
                },
                icon: Icon(Icons.close),
              )
            : IconButton(onPressed: () {}, icon: Icon(Icons.search)),
      ],
      automaticallyImplyBackButton: false,
      controller: searchBarController,
      margins: EdgeInsetsGeometry.only(top: 55, left: 23, right: 23),
      width: 234,
      openWidth: 400,
      axisAlignment: -0.4,
      height: 54,
      hint: 'Search...',
      hintStyle: TextStyle(fontSize: 17.5, color: Colors.grey.shade400),
      progress: state.isLoading,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      borderRadius: BorderRadius.circular(20),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        ref.read(searchBarControllerProvider.notifier).search(query);
      },
      transition: CircularFloatingSearchBarTransition(),
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 2,
              children: state.when(
                data: (pois) => pois
                    .map(
                      (poi) => PoiResultCard(
                        poi: poi,
                        onTap: () {
                          searchBarController.close();
                          onResultTap(poi);
                        },
                      ),
                    )
                    .toList(),
                loading: () => [], // TODO implementare qui il loading
                error: (e, _) => [Text('Error: $e')],
              ),
            ),
          ),
        );
      },
    );
  }
}
