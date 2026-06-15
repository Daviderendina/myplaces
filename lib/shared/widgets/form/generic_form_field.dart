import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';

class GenericFormField extends StatelessWidget {
  final String label;
  final Widget child;

  // TODO validator

  const GenericFormField({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: AppLayout.form.getSubtitleSpacing(context)),
        Padding(padding: AppLayout.form.getFieldInternalMapping(context), child: child),
      ],
    );
  }
}
