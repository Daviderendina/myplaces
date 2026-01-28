import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteBox extends StatelessWidget {
  final String actualNote;
  final ValueChanged<String> onSubmitted;
  final FocusNode? focusNode;

  const NoteBox({
    super.key,
    required this.actualNote,
    required this.onSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    if (actualNote.isNotEmpty) {
      textEditingController.text = actualNote;
    }
    return TextField(
      cursorColor: Colors.white,
      enableInteractiveSelection: false,
      maxLines: 3,
      minLines: 1,

      controller: textEditingController,
      focusNode: focusNode,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white12),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white12),
          borderRadius: BorderRadius.circular(10),
        ),

        prefixIcon: const Icon(
          Icons.note_alt_outlined,
          color: Colors.white70,
          size: 20,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 48,
          minHeight: 40,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
      ),
      onSubmitted: onSubmitted,
      onTapOutside: (_) {
        print("!!!!!!!!!!!!!!!!!!");
        onSubmitted(textEditingController.text);
        FocusScope.of(context).unfocus();
      },
    );
  }
}
