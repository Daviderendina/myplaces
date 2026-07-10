import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';

import '../../../core/constants/AppTheme.dart';

enum _IconAppType { primary, surfaceTransparent, transparent }

enum IconAppShape { circular, square }

class IconAppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final double buttonSize;
  final double iconSize;
  final IconAppShape shape;
  final double backgroundAlpha;

  final _IconAppType _type;

  const IconAppButton.primary({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.buttonSize,
    required this.iconSize,
    this.backgroundAlpha = 1,
    this.shape = IconAppShape.circular,
  }) : _type = _IconAppType.primary;

  const IconAppButton.surfaceTransparent({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.buttonSize,
    required this.iconSize,
    this.backgroundAlpha = AppTheme.surfaceAlpha,
    this.shape = IconAppShape.circular,
  }) : _type = _IconAppType.surfaceTransparent;

  const IconAppButton.transparent({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.buttonSize,
    required this.iconSize,
    this.backgroundAlpha = 0,
    this.shape = IconAppShape.circular,
  }) : _type = _IconAppType.transparent;

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = switch (_type) {
      _IconAppType.primary => Theme.of(context).colorScheme.primary,
      _IconAppType.surfaceTransparent => Theme.of(context).colorScheme.surface,
      _IconAppType.transparent => Colors.transparent,
    };

    Color iconColor = switch (_type) {
      _IconAppType.primary => Theme.of(context).colorScheme.onPrimary,
      _IconAppType.surfaceTransparent => Theme.of(
        context,
      ).colorScheme.onSurface,
      _IconAppType.transparent => Theme.of(context).colorScheme.primary,
    };

    double radius = switch (shape) {
      IconAppShape.circular => 1000,
      IconAppShape.square => AppLayout.geometry.radiusMedium,
    };

    return Container(
      height: buttonSize,
      width: buttonSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: backgroundColor.withValues(alpha: backgroundAlpha),
      ),
      child: IconButton(
        icon: Icon(icon, size: iconSize),
        color: iconColor,
        onPressed: onPressed,
        constraints: const BoxConstraints(),
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
