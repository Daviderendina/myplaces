import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/features/collections/models/collection.dart';
import 'package:myplaces/shared/widgets/circled_emoji.dart';

class CollectionListTile extends StatelessWidget {
  final Collection collection;

  const CollectionListTile({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircledEmoji(collection: collection),
      title: Text(collection.name, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text('${collection.pois.length} places saved'),
      onTap: () {
        context.push('/collection-detail', extra: collection);
      },
    );
  }
}
