import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myplaces/features/collections/models/collection.dart';

class CollectionListTile extends StatelessWidget {
  final Collection collection;

  const CollectionListTile({super.key, required this.collection});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: collection.dominantEmojiColor.withAlpha(30),
        child: Text(collection.emoji),
      ),
      title: Text(collection.name, style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text('ID: ${collection.id}'),
      onTap: () {
        // TODO: Navigazione
      },
    );
  }
}
