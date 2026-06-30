import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import '../../../features/collections/models/collection.dart';

class CircledEmoji extends StatelessWidget {
  final Collection collection;
  final bool addBorder;
  final bool isDisabled;

  const CircledEmoji({
    super.key,
    required this.collection,
    this.addBorder = false,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDisabled
        ? Theme.of(context).disabledColor
        : collection.emoji.color;

    final double diameter = AppLayout.spaces.horizontalMedium * 2;

    return Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        shape: BoxShape.circle,
        border: addBorder
            ? Border.all(color: color.withValues(alpha: .40), width: 1.0)
            : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(AppLayout.spaces.horizontalXSmall),
        child: Opacity(
          opacity: isDisabled ? 0.1 : 1.0,
          child: Text(
            collection.emoji.value,
            style: TextStyle(fontSize: AppLayout.icons.emojiSmall, height: 1),
          ),
        ),
      ),
    );
  }
}
