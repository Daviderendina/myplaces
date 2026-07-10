import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'icon_app_button.dart';

class TransparentBackButton extends StatelessWidget {
  const TransparentBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconAppButton.surfaceTransparent(
      icon: Icons.arrow_back_outlined,
      buttonSize: AppLayout.buttons.circularMedium,
      iconSize: AppLayout.icons.medium,
      onPressed: () => Navigator.pop(context),
    );
  }
}
