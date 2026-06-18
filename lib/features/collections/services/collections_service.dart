import 'dart:math';
import 'package:flutter/material.dart';
import '../models/collection.dart';
import '../repositories/collection_repository.dart';

class CollectionService {
  final CollectionRepository _repository;

  CollectionService(this._repository);

  Stream<List<Collection>> watchCollections() => _repository.watchCollections();

  Future<List<Collection>> fetchAll() => _repository.fetchAll();

  Future<bool> addCollection(String name, String emoji) async {
    final c = Collection(id: '', name: name, emoji: emoji);
    // TODO no nomi duplicati
    // TODO non funziona controllo su emoji
    // TODO fare controlli e calcolo colore
    return _repository.addCollection(c);
    //return Random().nextBool();
  }
}
