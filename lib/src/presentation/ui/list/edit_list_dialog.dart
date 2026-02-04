import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/presentation/ui/common/my_subtitle.dart';
import 'package:myplaces/src/providers.dart';

import '../common/my_emoji_picker.dart';

class EditListFullDialog extends ConsumerStatefulWidget {
  const EditListFullDialog({super.key});

  @override
  ConsumerState<EditListFullDialog> createState() => _EditListScreenState();
}

class _EditListScreenState extends ConsumerState<EditListFullDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  String? selectedEmoji;
  bool? hiddenList;

  @override
  void initState() {
    super.initState();
    final myList = ref.read(selectedListControllerProvider);
    _controller = TextEditingController(text: myList?.name ?? '');
    selectedEmoji = myList?.emoji;
    hiddenList = myList?.isArchived;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    await ref
        .read(selectedListControllerProvider.notifier)
        .updateList(
          newEmoji: selectedEmoji,
          isHidden: hiddenList,
          name: _controller.text,
        );
    await ref.read(listsControllerProvider.notifier).refresh();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit list'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [IconButton(icon: const Icon(Icons.check), onPressed: _save)],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MySubtitle(text: "Name"),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _controller,
                  cursorColor: Colors.white,
                  enableInteractiveSelection: false,

                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white12),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red.withAlpha(200)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red.withAlpha(200)),
                      borderRadius: BorderRadius.circular(8),
                    ),

                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 14,
                    ),
                  ),
                  validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                ),

                SizedBox(height: 40),

                MySubtitle(text: "Hidden list"),
                Row(
                  children: [
                    SizedBox(
                      width: 300,
                      child: Text(
                        "If activated, the lists will be hide from the saved page",
                        maxLines: 2,
                      ),
                    ),
                    Spacer(),
                    Switch(
                      value: hiddenList ?? false,
                      onChanged: (value) => setState(() {
                        hiddenList = value;
                      }),
                    ),
                  ],
                ),

                SizedBox(height: 40),

                Row(
                  spacing: 22,
                  children: [
                    MySubtitle(text: "Select an emoji"),
                    Text(
                      selectedEmoji ?? '?',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MyEmojiPicker(
                      onEmojiSelected: (emoji) {
                        setState(() {
                          selectedEmoji = emoji;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showEditListFullDialog(BuildContext context) {
  Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => const EditListFullDialog(),
    ),
  );
}
