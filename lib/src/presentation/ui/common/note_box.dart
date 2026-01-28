import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoteBox extends StatelessWidget {
  final String actualNote;
  final VoidCallback onTap;

  const NoteBox({super.key, required this.actualNote, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(color: Colors.white.withAlpha(10)),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.sticky_note_2_outlined,
                  color: Colors.white.withAlpha(180),
                  size: 24,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    actualNote,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.5,
                      color: Colors.white.withAlpha(180),
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
