import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/AppLayout.dart';

class TextAppButton extends StatefulWidget {
  final String text;
  final FutureOr<void> Function()? onPressed;

  const TextAppButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  State<TextAppButton> createState() => _TextAppButtonState();
}

class _TextAppButtonState extends State<TextAppButton> {
  bool _isLoading = false;

  Future<void> _handlePressed() async {
    if (widget.onPressed == null || _isLoading) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed!();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: AppLayout.button.getLargeHeight(context),
      child: ElevatedButton(
        onPressed: widget.onPressed == null || _isLoading ? null : _handlePressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          disabledBackgroundColor: theme.disabledColor.withOpacity(0.12),
          disabledForegroundColor: theme.disabledColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: theme.colorScheme.onPrimary,
                ),
              )
            : Text(
                widget.text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
      ),
    );
  }
}
