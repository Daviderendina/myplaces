import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/presentation/ui/common/my_subtitle.dart';
import 'package:myplaces/src/providers.dart';

import '../../../domain/my_list.dart';
import '../common/my_emoji_picker.dart';

class ListInformationFullDialog extends ConsumerStatefulWidget {
  final ListInformationAction action;

  const ListInformationFullDialog({super.key, required this.action});

  @override
  ConsumerState<ListInformationFullDialog> createState() =>
      _EditListScreenState();
}

class _EditListScreenState extends ConsumerState<ListInformationFullDialog> {
  late final TextEditingController _controller;
  final _formKey = GlobalKey<FormState>();

  String? selectedEmoji;
  late bool hiddenList;

  @override
  void initState() {
    super.initState();
    MyList? myList = widget.action == ListInformationAction.CREATE
        ? null
        : ref.read(selectedListControllerProvider);
    _controller = TextEditingController(text: myList?.name ?? '');
    selectedEmoji = myList?.emoji;
    hiddenList = myList?.isArchived ?? false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    String name = _controller.text;
    bool isHidden = hiddenList;
    String emoji = selectedEmoji!;

    if (widget.action == ListInformationAction.CREATE) {
      final newList = MyList(name: name, emoji: emoji, isArchived: isHidden);
      ref.read(listsControllerProvider.notifier).addList(newList);
    } else if (widget.action == ListInformationAction.EDIT) {
      await ref
          .read(selectedListControllerProvider.notifier)
          .updateList(newEmoji: emoji, isHidden: isHidden, name: name);
      await ref.read(listsControllerProvider.notifier).refresh();
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.action == ListInformationAction.CREATE
              ? 'Create List'
              : 'Edit List',
        ),
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
                    errorStyle: TextStyle(color: Colors.red.withAlpha(200)),

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
                      value: hiddenList,
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
                      selectedEmoji ?? '',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                FormField<String>(
                  autovalidateMode: AutovalidateMode.disabled,
                  initialValue: selectedEmoji,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Emoji not selected';
                    }
                    return null;
                  },
                  builder: (FormFieldState<String> field) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: field.hasError
                                    ? Colors.red.withAlpha(200)
                                    : Colors.white12,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: MyEmojiPicker(
                                onEmojiSelected: (emoji) {
                                  setState(() {
                                    selectedEmoji = emoji;
                                  });
                                  field.didChange(selectedEmoji);
                                },
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 5),
                        if (field.hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 22),
                            child: Text(
                              field.errorText!,
                              style: TextStyle(
                                color: Colors.red.withAlpha(200),
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                height:
                                    1.2, // line height simile al TextFormField
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void showListInformationFullDialog(
  BuildContext context,
  ListInformationAction action,
) {
  Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => ListInformationFullDialog(action: action),
    ),
  );
}

enum ListInformationAction { CREATE, EDIT }
