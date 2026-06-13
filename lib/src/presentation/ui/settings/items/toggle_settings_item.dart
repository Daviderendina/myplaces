import 'package:flutter/material.dart';
import 'package:myplaces/src/presentation/ui/settings/items/settings_item.dart';

class ToggleSettingsItem extends StatefulWidget {
  final String title;
  final String? subtitle;
  final bool initialValue;
  final ValueChanged<bool>? onChanged;

  const ToggleSettingsItem({
    super.key,
    required this.title,
    this.subtitle,
    this.initialValue = false,
    this.onChanged,
  });

  @override
  State<ToggleSettingsItem> createState() => _ToggleSettingsItemState();
}

class _ToggleSettingsItemState extends State<ToggleSettingsItem> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      title: widget.title,
      subtitle: widget.subtitle,
      trailing: Switch(
        value: _value,
        onChanged: (val) {
          setState(() => _value = val);
          widget.onChanged?.call(val);
        },
      ),
    );
  }
}
