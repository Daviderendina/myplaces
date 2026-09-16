import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';

/// Wrapper comune (decorazione + padding) condiviso da [PoiSummarySheet],
/// [PoiSummarySheetOnLoading] e [PoiSummarySheetOnError].
class PoiSummarySheetContainer extends StatelessWidget {
  final Widget child;

  const PoiSummarySheetContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        borderRadius: BorderRadius.circular(AppLayout.geometry.radiusLarge),
      ),
      child: Padding(
        padding: EdgeInsetsGeometry.all(AppLayout.screenWidth * .035),
        child: child,
      ),
    );
  }
}
