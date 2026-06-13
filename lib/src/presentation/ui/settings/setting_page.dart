import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/config/settings_keys.dart';
import 'package:myplaces/src/presentation/ui/common/main_page_padding.dart';
import 'package:myplaces/src/presentation/ui/settings/items/action_settings_item.dart';
import 'package:myplaces/src/providers.dart';

import '../common/custombox/custom_titled_box.dart';
import '../common/main_page_title.dart';
import 'items/file_picker_settings_item.dart';
import 'items/toggle_settings_item.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(settingsServiceProvider)
        .when(
          loading: () => const CircularProgressIndicator(),
          error: (e, _) => Center(child: Text('Errore durante il recupero delle impostazioni')),
          data: (settings) => SingleChildScrollView(
            child: MainPagePadding(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MainPageTitle(text: "Settings"),
                  CustomTitledBox(
                    title: "Local backup",
                    width: double.infinity,
                    children: [
                      ToggleSettingsItem(
                        title: "Automatic backup",
                        subtitle: "Enable automatic local backups",
                        initialValue:
                            settings.getValue(SettingsKeys.autoBackupEnabled) as bool? ?? false,
                        onChanged: (value) =>
                            settings.setValue(SettingsKeys.autoBackupEnabled, value),
                      ),
                      FilePickerSettingsItem(
                        title: "Backup path",
                        initialFolder: settings.getValue(SettingsKeys.autoBackupPath) as String?,
                        onChanged: (value) => settings.setValue(SettingsKeys.autoBackupPath, value),
                      ),
                      ActionSettingsItem(
                        title: "Backup now",
                        subtitle: "Create a backup in the selected path",
                        icon: Icons.keyboard_arrow_right,
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
