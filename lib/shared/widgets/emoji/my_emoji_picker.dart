import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

class MyEmojiPicker extends StatefulWidget {
  final void Function(String emoji)? onEmojiSelected;
  final double height;
  final String? initialEmoji;

  const MyEmojiPicker({
    super.key,
    this.onEmojiSelected,
    required this.height,
    this.initialEmoji,
  });

  @override
  State<MyEmojiPicker> createState() => _MyEmojiPickerState();
}

class _MyEmojiPickerState extends State<MyEmojiPicker> {
  Category selectedCategory = Category.SMILEYS;
  String? _selectedEmoji;

  @override
  void initState() {
    super.initState();
    _selectedEmoji = widget.initialEmoji;
  }

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
    var height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).disabledColor,
                      size: selectedCategory == k ? 28 : 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: height * .025),

        SizedBox(
          height: widget.height,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: emojiList.length,
            itemBuilder: (context, index) {
              final emoji = emojiList[index];
              final isSelected = _selectedEmoji == emoji;

              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  setState(() {
                    _selectedEmoji = emoji;
                  });
                  widget.onEmojiSelected?.call(emoji);
                },
                child: Opacity(
                  opacity: isSelected ? 1.0 : 0.25,
                  child: Center(
                    child: Text(emoji, style: TextStyle(fontSize: 24)),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
