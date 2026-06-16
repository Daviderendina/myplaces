import 'package:flutter/material.dart';

class SecondaryTitledScreen extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;
  final VoidCallback? onEditPressed;

  const SecondaryTitledScreen({
    super.key,
    required this.title,
    required this.child,
    this.subtitle,
    this.onEditPressed,
  });

  // TODO rivedere gli stili

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const BackButton(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.titleMedium),
                      if (subtitle != null)
                        Text(subtitle!, style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ),
                if (onEditPressed != null)
                  IconButton(icon: const Icon(Icons.edit_outlined), onPressed: onEditPressed),
              ],
            ),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
