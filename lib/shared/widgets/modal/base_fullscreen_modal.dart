import 'package:flutter/material.dart';
import '../../../core/constants/AppLayout.dart';

class BaseFullscreenModal extends StatelessWidget {
  final Widget child;
  final String? title;

  const BaseFullscreenModal({super.key, required this.child, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Padding(
                padding: AppLayout.getFullscreenModalPadding(context),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (title != null) ...[
                      Text(
                        title!,
                        style: Theme.of(context).textTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: AppLayout.form.getTitleSpacing(context)),
                    ],
                    Expanded(child: child),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
