import 'package:myplaces/core/models/poi.dart';
import 'package:myplaces/features/search/repositories/photo_repository.dart';
import 'package:myplaces/features/search/repositories/search_repository.dart';

import '../../../core/models/poi_image.dart';
import '../model/PoiPreview.dart';

class SearchService {
  final SearchRepository _repository;
  final PhotoRepository _photoRepository;

  SearchService(this._repository, this._photoRepository);

  Future<List<PoiPreview>> search(String query) async {
    if (query.isEmpty) return [];
    return await _repository.search(query);
  }

  Future<Poi> getPoiDetailFromPreview(PoiPreview preview) async {
    if (preview.id.trim().isEmpty || preview.osmType.trim().isEmpty) {
      throw const FormatException('PoiPreview is required to lookup a POI');
    }

    final results = await Future.wait([
      _repository.searchByIdAndType(preview.osmType.trim(), preview.id),
      _photoRepository.search(preview.photoQuery),
    ], eagerError: false);

    final poi = results[0] as Poi;
    final photosResult = results[1] as List<PoiImage>;

    return poi.copyWith(photos: photosResult);
  }
}
