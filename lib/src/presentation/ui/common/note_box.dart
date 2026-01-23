import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteBox extends StatelessWidget {
  final String actualNote;
  final ValueChanged<String> onSubmitted;

  const NoteBox({
    super.key,
    required this.actualNote,
    required this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    if (actualNote.isNotEmpty) {
      textEditingController.text = actualNote;
    }
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onSubmitted: onSubmitted,
      onTapOutside: (_) {
        onSubmitted(textEditingController.text);
        FocusScope.of(context).unfocus();
      },
    );
  }
}
