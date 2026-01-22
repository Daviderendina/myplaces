import 'package:flutter/material.dart';

final EdgeInsetsGeometry chipPadding = EdgeInsetsGeometry.symmetric(
  horizontal: 5,
);
final OutlinedBorder chipBorder = const StadiumBorder();
final Color color = Colors.white70;
final TextStyle textStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: color,
);
final double iconSize = 16;

class MyActionChip extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MyActionChip({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text(title, style: textStyle),
      avatar: Icon(icon, color: color, size: iconSize),
      onPressed: onTap,
      elevation: 0,
      pressElevation: 0,
      shape: chipBorder,
      padding: chipPadding,
    );
  }
}

class MyFilterChip extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final ValueChanged<bool> onSelected;
  final Color selectedColor;

  const MyFilterChip({
    super.key,
    required this.title,
    required this.icon,
    required this.selected,
    required this.onSelected,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        title,
        style: textStyle.copyWith(color: selected ? selectedColor : color),
      ),
      avatar: Icon(
        icon,
        size: iconSize,
        color: selected ? selectedColor : color,
      ),
      selectedColor: selectedColor.withAlpha(60),
      selected: selected,
      onSelected: onSelected,
      elevation: 0,
      pressElevation: 0,
      shape: chipBorder,
      padding: chipPadding,
      showCheckmark: false,
    );
  }
}
