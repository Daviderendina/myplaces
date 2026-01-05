import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_floating_search_bar_plus/material_floating_search_bar_plus.dart';
import 'package:myplaces/components/map_page/poi_result_card.dart';

import '../../models/poi.dart';
import '../../providers.dart';

class MyFloatingSearchBar extends ConsumerWidget {
  final FloatingSearchBarController searchBarController;
  final bool isSearching;
  final List<Poi> searchResults;
  final Function(Poi poi) onResultTap;

  const MyFloatingSearchBar({
    required this.searchBarController,
    required this.isSearching,
    required this.searchResults,
    required this.onResultTap,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(mapPageProvider);

    return FloatingSearchBar(
      actions: [
        state.searchPoiResultToShow != null
            ? IconButton(
                onPressed: () {
                  ref.read(mapPageProvider.notifier).clearMap();
                },
                icon: Icon(Icons.close),
              )
            : IconButton(onPressed: () {}, icon: Icon(Icons.search)),
      ],
      automaticallyImplyBackButton: false,
      controller: searchBarController,
      margins: EdgeInsetsGeometry.only(top: 55, left: 30, right: 30),
      height: 54,
      hint: 'Search...',
      hintStyle: TextStyle(fontSize: 17.5, color: Colors.grey.shade400),
      progress: isSearching,
      leadingActions: [
        FloatingSearchBarAction(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.map_outlined, color: Colors.grey.shade400),
          ),
        ),
      ],
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      borderRadius: BorderRadius.circular(100),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        ref.read(mapPageProvider.notifier).search(query);
      },
      transition: CircularFloatingSearchBarTransition(),
      builder: (context, transition) {
        final results = searchResults;

        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 1,
              children: results.map((poi) {
                return PoiResultCard(poi: poi, onTap: () => {onResultTap(poi)});
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
