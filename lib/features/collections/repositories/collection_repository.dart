import 'dart:async';

import 'package:flutter/material.dart';

import '../models/collection.dart';

class CollectionRepository {
  final _controller = StreamController<List<Collection>>.broadcast();

  List<Collection> _cache = []; // cache locale

  CollectionRepository();

  Stream<List<Collection>> watchCollections() => _controller.stream;

  Future<List<Collection>> fetchAll() async {
    await Future.delayed(const Duration(milliseconds: 800));
    _cache = [
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
    return _cache;
  }

  Future<bool> addCollection(Collection c) async {
    // await _client.insert(c); // salva sul DB
    _cache = [..._cache, c]; // aggiorna la cache locale
    _controller.add(_cache); // emette la cache aggiornata

    return true;
  }

  void dispose() => _controller.close();
}
