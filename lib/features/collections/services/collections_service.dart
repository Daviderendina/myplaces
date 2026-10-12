import 'package:myplaces/core/models/poi/poi_preview.dart';
import 'package:myplaces/features/collections/models/emoji.dart';

import '../models/collection.dart';
import '../repositories/collection_repository.dart';

class CollectionsService {
  final CollectionRepository _repository;

  CollectionsService(this._repository);

  Stream<List<Collection>> watchCollections() => _repository.watchCollections();

  Future<List<Collection>> fetchAll() => _repository.fetchAll();

  Future<List<Collection>> fetchAllVisible() =>
      fetchAll().then((collections) => collections.where((c) => c.visibleOnMap).toList());

  Future<bool> addCollection(String name, String emojiText) async {
    MyEmoji emoji = await MyEmoji.create(emojiText);
    final c = Collection(id: '', name: name, emoji: emoji);
    // TODO no nomi duplicati
    // TODO fare controlli
    return _repository.addCollection(c);
    //return Random().nextBool();
  }

  Future<void> setVisibleCollections(Set<String> visibleIds) =>
      _repository.setVisibleCollections(visibleIds);

  Future<List<Collection>> getCollectionByPoi(PoiPreview poi) {
    return fetchAll(); //.then((lists) => lists.where((c) => c.pois.contains(poi)).toList());
  }
}
