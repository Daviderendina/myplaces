import 'package:flutter/cupertino.dart';
import 'package:myplaces/src/presentation/ui/settings/items/settings_item.dart';

class ActionSettingsItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const ActionSettingsItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      trailing: Icon(icon, size: 32),
    );
  }
}
