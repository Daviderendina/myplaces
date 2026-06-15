import 'package:flutter/material.dart';

import '../../core/constants/AppLayout.dart';

class AppSnackBar {
  static void success(BuildContext context, String message, {double bottom = 16}) {
    _show(context, message, Colors.green.shade600, Icons.check_circle_rounded, bottom);
  }

  static void warn(BuildContext context, String message, {double bottom = 16}) {
    _show(context, message, Colors.orange.shade800, Icons.warning_amber_outlined, bottom);
  }

  static void error(BuildContext context, String message, {double bottom = 16}) {
    _show(context, message, Colors.red.shade600, Icons.error_rounded, bottom);
  }

  static void _show(
    BuildContext context,
    String message,
    Color backgroundColor,
    IconData icon,
    double bottom,
  ) {
    Size size = MediaQuery.of(context).size;

    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: backgroundColor,
        margin: EdgeInsets.symmetric(
          vertical: size.height * 0.1,
          horizontal: AppLayout.getFullscreenModalPadding(context).left,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
