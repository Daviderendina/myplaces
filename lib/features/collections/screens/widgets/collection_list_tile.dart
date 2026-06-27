import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/collections/models/collection.dart';
import 'package:myplaces/shared/widgets/circled_emoji.dart';

class CollectionListTile extends StatelessWidget {
  final Collection collection;
  final bool isDisabled;
  final VoidCallback? onPressed;

  const CollectionListTile({
    super.key,
    required this.collection,
    this.isDisabled = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(1000),
      onTap:
          onPressed ??
          () => context.push('/collection-detail', extra: collection),
      child: Row(
        spacing: AppLayout.space.getHorizontalXSmall(context),
        children: [
          CircledEmoji(collection: collection, isDisabled: isDisabled),
          SizedBox(width: AppLayout.space.getHorizontalXSmall(context)),
          Text(
            collection.name,
            style: getStyle(
              context,
              Theme.of(context).textTheme.labelLarge,
              isDisabled,
            ),
          ),
          Text(
            "/",
            style: getStyle(
              context,
              Theme.of(context).textTheme.labelSmall,
              isDisabled,
            ),
          ),
          Text(
            "${collection.pois.length} places",
            style: getStyle(
              context,
              Theme.of(context).textTheme.labelSmall,
              isDisabled,
            ),
          ),
        ],
      ),
    );
  }

  TextStyle? getStyle(BuildContext context, TextStyle? style, bool isDisabled) {
    return isDisabled
        ? style?.copyWith(color: Theme.of(context).disabledColor)
        : style;
  }
}
