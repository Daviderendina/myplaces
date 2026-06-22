import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myplaces/core/models/poi.dart';

import '../models/collection.dart';
import '../models/emoji.dart';

class CollectionRepository {
  final _controller = StreamController<List<Collection>>.broadcast();

  List<Collection> _cache = []; // cache locale

  CollectionRepository();

  Stream<List<Collection>> watchCollections() => _controller.stream;

  Future<List<Collection>> fetchAll() async {
    await Future.delayed(const Duration(milliseconds: 800));
    _cache = [
      Collection(
        id: '1',
        name: 'Preferiti',
        emoji: await MyEmoji.create('❤️'),
        pois: [
          Poi(
            id: "0",
            name: "Cimone di Margno",
            coordinates: Coordinates(latitude: 0.123, longitude: 0.123),
          ),
          Poi(
            id: "1",
            name: "Passo del Berlina",
            coordinates: Coordinates(latitude: 0.123, longitude: 0.123),
          ),
          Poi(
            id: "2",
            name: "Museo del Cairo",
            coordinates: Coordinates(latitude: 0.123, longitude: 0.123),
          ),
          Poi(id: "3", name: "Creta", coordinates: Coordinates(latitude: 0.123, longitude: 0.123)),
        ],
      ),
      Collection(id: '2', name: 'Da visitare', emoji: await MyEmoji.create('✈️')),
      Collection(id: '3', name: 'Ristoranti di pesce', emoji: await MyEmoji.create('🐟')),
      Collection(id: '4', name: 'Parchi', emoji: await MyEmoji.create('🌳')),
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
