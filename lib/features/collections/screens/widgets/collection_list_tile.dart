import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myplaces/features/collections/models/collection.dart';
import 'package:myplaces/shared/widgets/circled_emoji.dart';

import '../collection_detail_screen.dart';

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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CollectionDetailScreen(collection: collection)),
        ); // TODO mettere su controller della pagina!
      },
    );
  }
}
