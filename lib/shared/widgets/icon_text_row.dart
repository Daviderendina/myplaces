import 'package:flutter/material.dart';
import '../../core/constants/AppLayout.dart';

class IconTextRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconTextRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: AppLayout.icon.getMediumSize(context),
          color: Colors.grey[700],
        ), // TODO mettere nel theme
        SizedBox(width: AppLayout.space.getHorizontalSmall(context)),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ), // TODO label?
        ),
      ],
    );
  }
}
