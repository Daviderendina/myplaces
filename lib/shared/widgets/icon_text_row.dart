import 'package:flutter/material.dart';
import '../../core/constants/AppLayout.dart';

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconTextRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.sizeOf(context).width;

    return Row(
      children: [
        CircleAvatar(
          radius: width * 0.036,
          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
          child: Icon(
            icon,
            size: AppLayout.icon.getSmallSize(context),
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(width: AppLayout.space.getHorizontalSmall(context)),
        Expanded(
          child: Text(text, style: Theme.of(context).textTheme.labelMedium),
        ),
      ],
    );
  }
}
