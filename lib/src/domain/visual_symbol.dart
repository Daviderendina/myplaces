import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VisualSymbol {
  final IconData? icon;
  final Color? iconColor;
  final String? emoji;

  const VisualSymbol.icon(this.icon, this.iconColor) : emoji = null;

  const VisualSymbol.emoji(this.emoji) : icon = null, iconColor = null;

  bool get isIcon => icon != null;

  bool get isEmoji => emoji != null;
}
