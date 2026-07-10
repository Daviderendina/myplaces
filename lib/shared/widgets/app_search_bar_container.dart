import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/core/constants/AppTextTheme.dart';

import '../../core/constants/AppTheme.dart';

class AppSearchBar extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final String? hintText;
  final bool readOnly;
  final bool autofocus;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? cursorColor;
  final bool showShadow;

  const AppSearchBar({
    super.key,
    this.leading,
    this.trailing,
    this.hintText,
    this.readOnly = false,
    this.autofocus = false,
    this.controller,
    this.onChanged,
    this.onTap,
    this.width,
    this.height,
    this.backgroundColor,
    this.cursorColor,
    this.showShadow = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBackgroundColor =
        backgroundColor ??
        theme.colorScheme.surface.withValues(alpha: AppTheme.surfaceAlpha);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? AppLayout.buttons.circularLarge,
        decoration: BoxDecoration(
          color: effectiveBackgroundColor,
          borderRadius: BorderRadius.circular(AppLayout.geometry.radiusLarge),
          boxShadow: showShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppLayout.spaces.horizontalMedium,
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              SizedBox(width: AppLayout.spaces.horizontalSmall),
            ],
            Expanded(
              child: TextField(
                controller: controller,
                readOnly: readOnly,
                autofocus: autofocus,
                onTap: onTap,
                onChanged: onChanged,
                cursorColor: cursorColor ?? theme.hintColor,
                enableInteractiveSelection: false,
                decoration: InputDecoration(
                  hintText: hintText ?? '',
                  hintStyle: Theme.of(context).textTheme.hintText,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.zero,
                ),
                style: const TextStyle(fontSize: 16),
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: AppLayout.spaces.horizontalXSmall),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
