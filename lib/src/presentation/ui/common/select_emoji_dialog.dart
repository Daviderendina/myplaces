import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

Future<String?> showEmojiPickerDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (context) => _EmojiPickerDialog(),
  );
}

class _EmojiPickerDialog extends StatefulWidget {
  @override
  State<_EmojiPickerDialog> createState() => _EmojiPickerDialogState();
}

class _EmojiPickerDialogState extends State<_EmojiPickerDialog> {
  Category selectedCategory = Category.FLAGS;

  final Map<Category, IconData> categoryIcons = {
    Category.SMILEYS: Icons.tag_faces,
    Category.ANIMALS: Icons.pets,
    Category.FOODS: Icons.fastfood,
    Category.ACTIVITIES: Icons.sports_soccer,
    Category.TRAVEL: Icons.directions_car,
    Category.OBJECTS: Icons.lightbulb,
    Category.SYMBOLS: Icons.star,
    Category.FLAGS: Icons.flag,
  };

  List<String> get emojiList {
    final cat = defaultEmojiSet.firstWhere(
      (c) => c.category == selectedCategory,
      orElse: () => defaultEmojiSet.first,
    );
    return cat.emoji.map((e) => e.emoji).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: 550,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Titolo
              Text("Select an emoji", style: TextStyle(fontSize: 26)),

              // Barra categorie
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...categoryIcons.keys.map(
                      (k) => GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = k;
                          });
                        },
                        child: Icon(
                          categoryIcons[k],
                          color: selectedCategory == k
                              ? Colors.blue
                              : Colors.white24,
                          size: selectedCategory == k ? 28 : 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(color: Colors.white10),

              // Griglia emoji
              Expanded(
                child: GridView.count(
                  crossAxisCount: 7,
                  padding: const EdgeInsets.all(12),
                  children: emojiList.map((emoji) {
                    return InkWell(
                      onTap: () => Navigator.pop(context, emoji),
                      child: Center(
                        child: Text(
                          emoji,
                          style: const TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
