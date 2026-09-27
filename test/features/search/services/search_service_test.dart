import 'package:flutter_test/flutter_test.dart';
import 'package:latlong2/latlong.dart';
import 'package:myplaces/core/datasource/photo/IPhotoDataSource.dart';
import 'package:myplaces/core/datasource/poi/IPoiDataSource.dart';
import 'package:myplaces/core/models/poi.dart';
import 'package:myplaces/core/models/poi/poi_preview.dart';
import 'package:myplaces/core/models/poi_image.dart';
import 'package:myplaces/core/repository/AbstractMapper.dart';
import 'package:myplaces/features/search/repositories/photo_repository.dart';
import 'package:myplaces/features/search/repositories/search_repository.dart';
import 'package:myplaces/features/search/services/search_service.dart';

class _PoiDataSourceFake implements IPoiDataSource {
  @override
  Future<Map<String, dynamic>> search(String query) async => {};

  @override
  Future<Map<String, dynamic>> searchByIdAndType(String type, String id) async => {};
}

class _SearchMapperFake extends AbstractMapper<Map<String, dynamic>, List<PoiPreview>> {
  @override
  List<PoiPreview> map(Map<String, dynamic> data) => const [];
}

class _PoiMapperFake extends AbstractMapper<Map<String, dynamic>, Poi> {
  final Poi poi;

  _PoiMapperFake(this.poi);

  @override
  Poi map(Map<String, dynamic> data) => poi;
}

class _PhotoDataSourceFake implements IPhotoDataSource {
  @override
  Future<Map<String, dynamic>> search(String query) async => {};
}

class _PhotoMapperFake extends AbstractMapper<Map<String, dynamic>, List<PoiImage>> {
  final List<PoiImage> photos;

  _PhotoMapperFake(this.photos);

  @override
  List<PoiImage> map(Map<String, dynamic> data) => photos;
}

void main() {
  group('SearchService', () {
    test('enriches poi with photos when photo repository returns them', () async {
      final poi = Poi(id: '1', name: 'Fontana di Trevi', coordinates: const LatLng(41.0, 12.0));
      final searchRepository = SearchRepository(
        _PoiDataSourceFake(),
        _SearchMapperFake(),
        _PoiMapperFake(poi),
      );
      final photoRepository = PhotoRepository(
        _PhotoDataSourceFake(),
        _PhotoMapperFake(const [
          PoiImage(
            url: 'https://example.com/image.jpg',
            thumbnailUrl: 'https://example.com/thumb.jpg',
          ),
        ]),
      );
      final service = SearchService(searchRepository, photoRepository);

      final result = await service.getPoiDetailFromPreview(
        PoiPreview(id: '1', name: 'Fontana di Trevi', type: 'N'),
      );

      expect(result.photos, hasLength(1));
      expect(result.photos.first.url, 'https://example.com/image.jpg');
    });

    test('returns poi with empty photos when photo repository throws', () async {
      final poi = Poi(id: '1', name: 'Fontana di Trevi', coordinates: const LatLng(41.0, 12.0));
      final searchRepository = SearchRepository(
        _PoiDataSourceFake(),
        _SearchMapperFake(),
        _PoiMapperFake(poi),
      );
      final photoRepository = PhotoRepository(_PhotoDataSourceFake(), _PhotoMapperFake(const []));
      final service = SearchService(searchRepository, photoRepository);

      final result = await service.getPoiDetailFromPreview(
        PoiPreview(id: '1', name: 'Fontana di Trevi', type: 'N'),
      );

      expect(result.photos, isEmpty);
    });
  });
}
