import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myplaces/src/presentation/ui/settings/items/settings_item.dart';

class FilePickerSettingsItem extends StatefulWidget {
  final String title;
  final String? initialFolder;
  final ValueChanged<String?>? onChanged;

  const FilePickerSettingsItem({
    super.key,
    required this.title,
    this.initialFolder,
    this.onChanged,
  });

  @override
  State<FilePickerSettingsItem> createState() => _FilePickerSettingsItemState();
}

class _FilePickerSettingsItemState extends State<FilePickerSettingsItem> {
  late String? _selectedFolder;

  @override
  void initState() {
    super.initState();
    _selectedFolder = widget.initialFolder;
  }

  Future<void> _pickFolder() async {
    final String? folder = await FilePicker.platform.getDirectoryPath(lockParentWindow: true);
    if (folder != null) {
      setState(() => _selectedFolder = folder);
      widget.onChanged?.call(folder);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SettingsItem(
      title: widget.title,
      subtitle: _selectedFolder ?? "Nessuna cartella selezionata",
      trailing: IconButton(icon: const Icon(Icons.folder_open), onPressed: _pickFolder),
    );
  }
}
