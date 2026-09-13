import 'package:myplaces/features/collections/models/emoji.dart';
import '../models/collection.dart';
import '../repositories/collection_repository.dart';

class CollectionService {
  final CollectionRepository _repository;

  CollectionService(this._repository);

  Stream<List<Collection>> watchCollections() => _repository.watchCollections();

  Future<List<Collection>> fetchAll() => _repository.fetchAll();

  Future<List<Collection>> fetchAllVisible() => fetchAll().then(
    (collections) => collections.where((c) => c.visibleOnMap).toList(),
  );

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
}
