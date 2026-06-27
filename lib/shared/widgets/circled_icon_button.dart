import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';

class CircledIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  const CircledIconButton({
    super.key,
    required this.onPressed,
    this.icon = Icons.add_circle_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        color: Theme.of(context).colorScheme.primary,
        size: AppLayout.icon.getLargeSize(context),
      ),
      constraints: const BoxConstraints(),
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
    );
  }
}
