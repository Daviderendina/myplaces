import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';

class ElevatedContainer extends StatelessWidget {
  final Widget child;

  const ElevatedContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(AppLayout.geometry.radiusSmall),
      ),
      child: Padding(padding: AppLayout.geometry.containerPadding, child: child),
    );
  }
}
