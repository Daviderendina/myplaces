import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/core/constants/AppTheme.dart';
import '../../../../core/models/poi.dart';

class CollectionDetailCard extends StatelessWidget {
  final Poi poi;
  final String? imageUrl;

  const CollectionDetailCard({super.key, required this.poi, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/poi-detail', extra: poi),
      child: Row(
        children: [
          Card(
            child: SizedBox(
              width: AppLayout.collection.card.width(context),
              height: AppLayout.collection.card.height(context),
              child: Image.network(
                imageUrl ?? 'https://picsum.photos/seed/${poi.id}/400/300',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppTheme.light.disabledColor,
                  child: const Icon(Icons.image_not_supported),
                ),
              ),
            ),
          ),
          SizedBox(width: AppLayout.space.getHorizontalSmall(context)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  poi.name,
                  style: Theme.of(context).textTheme.titleMedium, // TODO
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Mountain / Lecco, Italy',
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
