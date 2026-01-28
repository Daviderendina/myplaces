import 'package:flutter/material.dart';
import 'package:myplaces/src/tools/extension/title_case_extension.dart';

final EdgeInsetsGeometry chipPadding = const EdgeInsets.symmetric(
  horizontal: 12,
  vertical: 6,
);
final OutlinedBorder chipBorder = RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
);
final Color color = Colors.white70;
final TextStyle textStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.w400,
  color: color,
);
final double iconSize = 20;

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
      label: Text(
        title.toTitleCase(),
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: color,
        ),
      ),
      avatar: Icon(icon, color: color, size: 19),
      onPressed: onTap,
      elevation: 0,
      pressElevation: 0,
      shape: chipBorder,
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 5),
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
