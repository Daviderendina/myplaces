import 'dart:async';
import 'package:flutter/material.dart';
import '../../../core/constants/AppLayout.dart';

enum _TextAppType { primary, alternative }

class TextAppButton extends StatefulWidget {
  final String text;
  final FutureOr<void> Function()? onPressed;
  final _TextAppType _type;
  final double? width;

  const TextAppButton({
    super.key,
    required this.text,
    this.width,
    this.onPressed,
  }) : _type = _TextAppType.primary;

  const TextAppButton.primary({
    super.key,
    required this.text,
    this.width,
    this.onPressed,
  }) : _type = _TextAppType.primary;

  const TextAppButton.alternative({
    super.key,
    required this.text,
    this.width,
    this.onPressed,
  }) : _type = _TextAppType.alternative;

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

    final backgroundColor = widget._type == _TextAppType.primary
        ? theme.colorScheme.primary
        : theme.colorScheme.onPrimary;

    final foregroundColor = widget._type == _TextAppType.primary
        ? theme.colorScheme.onPrimary
        : theme.colorScheme.primary;

    return SizedBox(
      width: widget.width ?? double.infinity,
      height: AppLayout.buttons.primaryHeight,
      child: ElevatedButton(
        onPressed: widget.onPressed == null || _isLoading
            ? null
            : _handlePressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          disabledBackgroundColor: theme.disabledColor.withValues(alpha: 0.12),
          disabledForegroundColor: theme.disabledColor,
          elevation: 0,
          side: widget._type == _TextAppType.alternative
              ? BorderSide(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                )
              : null,
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
                  color: foregroundColor,
                ),
              )
            : Text(
                widget.text,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: foregroundColor,
                ),
              ),
      ),
    );
  }
}
