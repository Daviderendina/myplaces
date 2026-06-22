import 'dart:ui';

import '../../../core/utils/emoji_utils.dart';

class MyEmoji {
  final String value;
  final Color color;

  MyEmoji({required this.value, required this.color});

  static Future<MyEmoji> create(String value) async {
    final color = await EmojiUtils.getColorFromEmoji(value);
    return MyEmoji(value: value, color: color);
  }
}
