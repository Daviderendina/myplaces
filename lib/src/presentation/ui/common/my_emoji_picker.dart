import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class MyEmojiPicker extends StatefulWidget {
  final void Function(String emoji)? onEmojiSelected; // 👈 parametro

  const MyEmojiPicker({super.key, this.onEmojiSelected});

  @override
  State<MyEmojiPicker> createState() => _MyEmojiPickerState();
}

class _MyEmojiPickerState extends State<MyEmojiPicker> {
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Barra categorie
        SizedBox(
          //height: 60,
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
                    color: selectedCategory == k ? Colors.blue : Colors.white24,
                    size: selectedCategory == k ? 28 : 24,
                  ),
                ),
              ),
            ],
          ),
        ),

        //const Divider(color: Colors.white10),
        SizedBox(height: 16),

        // Griglia emoji
        SizedBox(
          height: 240,
          child: GridView.count(
            crossAxisCount: 8,
            crossAxisSpacing: 10,
            //padding: const EdgeInsets.all(12),
            children: emojiList.map((emoji) {
              return InkWell(
                onTap: () {
                  if (widget.onEmojiSelected != null) {
                    widget.onEmojiSelected!(emoji); // 👈 chiama callback
                  } else {
                    Navigator.pop(context, emoji);
                  }
                },
                child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 24)),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
