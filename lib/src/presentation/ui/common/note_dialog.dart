import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteDialog extends StatelessWidget {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final String? value;
  final Function onSaveTap;

  NoteDialog({super.key, this.value, required this.onSaveTap});

  @override
  Widget build(BuildContext context) {
    controller.text = value ?? "";

    return AlertDialog(
      title: Row(
        spacing: 16,
        children: [
          Icon(Icons.note_alt_outlined, color: Colors.white.withAlpha(220)),
          const Text("Note"),
        ],
      ),
      content: SizedBox(
        width: 350,
        child: TextField(
          controller: controller,
          focusNode: focusNode,
          autofocus: true,

          maxLines: null,
          cursorColor: Colors.white,
          enableInteractiveSelection: false,

          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white12),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white12),
              borderRadius: BorderRadius.circular(10),
            ),

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 14,
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel", style: TextStyle(color: Colors.white)),
        ),
        ElevatedButton(
          onPressed: () {
            onSaveTap(controller.text);
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text("Save"),
        ),
      ],
    );
  }

  void dispose() {
    focusNode.dispose();
    controller.dispose();
  }
}

Future<String?> showNoteDialog(
  BuildContext context,
  String initialValue,
  Function(String) onSaveTap,
) async {
  var dialog = NoteDialog(value: initialValue, onSaveTap: onSaveTap);

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return dialog;
    },
  ).then((_) {
    dialog.dispose();
  });
}
