import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:myplaces/shared/widgets/button/icon_app_button.dart';
import 'package:myplaces/shared/widgets/map/map_view_screen.dart';
import '../../../core/constants/AppLayout.dart';
import '../../../shared/widgets/circled_emoji.dart';
import '../models/collection.dart';
import 'widgets/collection_detail_card.dart';

class CollectionDetailScreen extends StatefulWidget {
  final Collection collection;

  const CollectionDetailScreen({super.key, required this.collection});

  @override
  State<CollectionDetailScreen> createState() => _CollectionDetailScreenState();
}

class _CollectionDetailScreenState extends State<CollectionDetailScreen> {
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
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Map
          MapViewScreen(
            controller: _mapController,
            cameraPadding: EdgeInsets.only(
              bottom: size.height * .65,
              top: size.height * .10,
              left: size.width * .05,
              right: size.width * .05,
            ),
            markerBuilder: () => widget.collection.pois
                .map(
                  (poi) => Marker(
                    point: poi.coordinates,
                    child: CircledEmoji(collection: widget.collection),
                  ),
                )
                .toList(),
          ),

          // Draggable Bottom Sheet
          DraggableScrollableSheet(
            initialChildSize: 0.6,
            minChildSize: 0.3,
            maxChildSize: .96,
            builder: (context, scrollController) {
              return Container(
                padding: AppLayout.modals.bottomSheetPadding,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: .95),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(AppLayout.modals.bottomSheetRadius),
                  ),
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    // Pinned Header
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _CollectionHeaderDelegate(
                        collection: widget.collection,
                        onClose: () => Navigator.pop(context),
                      ),
                    ),

                    // Lazy Loaded POI List
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final poi = widget.collection.pois[index];
                          return Column(
                            children: [
                              CollectionDetailCard(poi: poi),
                              SizedBox(height: AppLayout.spaces.verticalSmall),
                            ],
                          );
                        }, childCount: widget.collection.pois.length),
                      ),
                    ),

                    // Extra bottom padding
                    const SliverToBoxAdapter(child: SizedBox(height: 20)),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CollectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Collection collection;
  final VoidCallback onClose;

  _CollectionHeaderDelegate({required this.collection, required this.onClose});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: AppLayout.spaces.verticalSmall),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        collection.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: AppLayout.spaces.horizontalSmall),
                    Text(
                      collection.emoji.value,
                      style: TextStyle(fontSize: AppLayout.icons.medium),
                    ),
                  ],
                ),
              ),
              IconAppButton.primary(
                icon: Icons.add,
                buttonSize: AppLayout.buttons.circularSmall,
                iconSize: AppLayout.icons.medium,
                onPressed: () {},
              ),
              SizedBox(width: AppLayout.spaces.horizontalSmall),
              IconAppButton.transparent(
                icon: Icons.close,
                buttonSize: AppLayout.buttons.circularMedium,
                iconSize: AppLayout.icons.medium,
                onPressed: onClose,
              ),
            ],
          ),
          Text(
            '${collection.pois.length} places',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 110;

  @override
  double get minExtent => 110;

  @override
  bool shouldRebuild(covariant _CollectionHeaderDelegate oldDelegate) {
    return oldDelegate.collection != collection;
  }
}
