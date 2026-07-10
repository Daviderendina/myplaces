import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/core/constants/AppTheme.dart';
import '../../../../core/models/poi.dart';

// TODO widgetname
class PoiCard extends StatelessWidget {
  final Poi poi;
  final String? imageUrl;

  const PoiCard({super.key, required this.poi, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('/poi-detail', extra: poi),
      child: Row(
        children: [
          Card(
            child: SizedBox(
              // TODO si possono mettere direttamente qui dentro? essendo proprio e non geneirci, oppure li rendo generici
              width: AppLayout.cards.collectionWidth,
              height: AppLayout.cards.collectionHeight,
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
          SizedBox(width: AppLayout.spaces.horizontalSmall),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  poi.name,
                  style: Theme.of(context).textTheme.titleLarge,
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
