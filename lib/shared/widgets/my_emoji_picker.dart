import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class MyEmojiPicker extends StatefulWidget {
  final void Function(String emoji)? onEmojiSelected;

  const MyEmojiPicker({super.key, this.onEmojiSelected});

  @override
  State<MyEmojiPicker> createState() => _MyEmojiPickerState();
}

class _MyEmojiPickerState extends State<MyEmojiPicker> {
  Category selectedCategory = Category.SMILEYS;

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
    // Usiamo LayoutBuilder per adattare il numero di colonne in base allo spazio se vuoi,
    // ma per ora manteniamo il conteggio fisso e rendiamo la griglia flessibile.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Barra categorie (Altezza fissa intrinseca)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...categoryIcons.keys.map(
                (k) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCategory = k;
                      });
                    },
                    child: Icon(
                      categoryIcons[k],
                      color: selectedCategory == k
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).disabledColor,
                      size: selectedCategory == k ? 28 : 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Griglia emoji - ORA OCCUPA TUTTO LO SPAZIO RIMANENTE
        Expanded(
          child: GridView.builder(
            // GridView.builder è più efficiente di .count per liste lunghe
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: emojiList.length,
            itemBuilder: (context, index) {
              final emoji = emojiList[index];
              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  if (widget.onEmojiSelected != null) {
                    widget.onEmojiSelected!(emoji);
                  } else {
                    Navigator.pop(context, emoji);
                  }
                },
                child: Center(child: Text(emoji, style: const TextStyle(fontSize: 24))),
              );
            },
          ),
        ),
      ],
    );
  }
}
