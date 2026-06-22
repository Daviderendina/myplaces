import 'package:flutter/material.dart';
import '../../../features/collections/models/collection.dart';

class CircledEmoji extends StatelessWidget {
  final Collection collection;
  final bool addBorder;

  const CircledEmoji({super.key, required this.collection, this.addBorder = false});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = collection.emoji.color.withValues(alpha: 0.17);
    final borderColor = collection.emoji.color.withValues(alpha: 0.4);

    var width = MediaQuery.sizeOf(context).width;

    final double radius = width * 0.055;
    final double diameter = radius * 2;
    final double internalPadding = width * 0.015;
    final double size = width * 0.045;

    return Container(
      width: diameter,
      height: diameter,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: addBorder ? Border.all(color: borderColor, width: 1.0) : null,
      ),
      child: Padding(
        padding: EdgeInsets.all(internalPadding),
        child: Text(collection.emoji.value, style: TextStyle(fontSize: size, height: 1)),
      ),
    );
  }
}
