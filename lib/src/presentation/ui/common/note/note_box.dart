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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Icon(
                    Icons.sticky_note_2_outlined,
                    color: Colors.white.withAlpha(180),
                    size: 16,
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Text(
                    actualNote,
                    maxLines: 8,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                      fontSize: 14,
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
