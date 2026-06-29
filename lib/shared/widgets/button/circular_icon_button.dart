import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';

enum _CircularIconButtonType { primary, surfaceTransparent, transparent }

enum CircularIconButtonShape { circular, square }

class CircularIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double size;
  final CircularIconButtonShape shape;

  final _CircularIconButtonType _type;

  const CircularIconButton.primary({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.size,
    this.shape = CircularIconButtonShape.circular,
  }) : _type = _CircularIconButtonType.primary;

  const CircularIconButton.surfaceTransparent({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.size,
    this.shape = CircularIconButtonShape.circular,
  }) : _type = _CircularIconButtonType.surfaceTransparent;

  const CircularIconButton.transparent({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.size,
    this.shape = CircularIconButtonShape.circular,
  }) : _type = _CircularIconButtonType.transparent;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = switch (_type) {
      _CircularIconButtonType.primary => Theme.of(context).colorScheme.primary,
      _CircularIconButtonType.surfaceTransparent => Theme.of(
        context,
      ).colorScheme.surface.withAlpha(100),
      _CircularIconButtonType.transparent => Colors.transparent,
    };

    Color iconColor = switch (_type) {
      _CircularIconButtonType.primary => Theme.of(
        context,
      ).colorScheme.onPrimary,
      _CircularIconButtonType.surfaceTransparent => Theme.of(
        context,
      ).colorScheme.onSurface,
      _CircularIconButtonType.transparent => Theme.of(
        context,
      ).colorScheme.primary,
    };

    double radius = switch (shape) {
      CircularIconButtonShape.circular => 1000,
      CircularIconButtonShape.square => AppLayout.button.getSquareButtonRadius(
        context,
      ),
    };

    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor,
      ),
      child: IconButton(
        icon: Icon(icon),
        color: iconColor,
        onPressed: onPressed,
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
