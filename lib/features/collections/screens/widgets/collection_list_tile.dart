import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/collections/models/collection.dart';
import 'package:myplaces/shared/widgets/emoji/circled_emoji.dart';

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
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(1000),
      onTap:
          onPressed ??
          () => context.push('/collection-detail', extra: collection),
      child: Row(
        spacing: AppLayout.spaces.horizontalXSmall,
        children: [
          CircledEmoji(collection: collection, isDisabled: isDisabled),
          SizedBox(width: AppLayout.spaces.horizontalXSmall),
          Text(
            collection.name,
            style: _getStyle(theme.textTheme.labelLarge, theme.disabledColor),
          ),
          Text(
            "/",
            style: _getStyle(theme.textTheme.labelSmall, theme.disabledColor),
          ),
          Text(
            "${collection.pois.length} places",
            style: _getStyle(theme.textTheme.labelSmall, theme.disabledColor),
          ),
        ],
      ),
    );
  }

  TextStyle? _getStyle(TextStyle? style, Color disabledColor) {
    return isDisabled ? style?.copyWith(color: disabledColor) : style;
  }
}
