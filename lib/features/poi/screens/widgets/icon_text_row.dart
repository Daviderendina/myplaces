import 'package:flutter/material.dart';
import 'package:myplaces/shared/widgets/button/icon_app_button.dart';
import '../../../../core/constants/AppLayout.dart';

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconTextRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final radius = AppLayout.icons.small;

    return Row(
      children: [
        IconAppButton.primary(
          onPressed: () {},
          icon: Icons.location_pin,
          buttonSize: AppLayout.buttons.circularXSmall,
          iconSize: AppLayout.icons.xsmall,
        ),
        SizedBox(width: AppLayout.spaces.horizontalSmall),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.labelMedium),
        ),
      ],
    );
  }
}
