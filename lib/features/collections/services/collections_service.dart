import 'package:flutter/material.dart';

import '../models/collection.dart';

class CollectionsService {
  Future<List<Collection>> getCollections() async {
    // Mocked data
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      Collection(id: '1', name: 'Preferiti', emoji: '❤️', dominantEmojiColor: Colors.red),
      Collection(id: '2', name: 'Da visitare', emoji: '✈️', dominantEmojiColor: Colors.blue),
      Collection(
        id: '3',
        name: 'Ristoranti di pesce',
        emoji: '🐟',
        dominantEmojiColor: Colors.lightBlue,
      ),
      Collection(id: '4', name: 'Parchi', emoji: '🌳', dominantEmojiColor: Colors.green),
    ];
  }
}
