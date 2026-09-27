import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:myplaces/core/datasource/photo/IPhotoDataSource.dart';
import 'package:myplaces/core/errors/app_exceptions.dart';
import 'package:myplaces/core/models/poi_image.dart';
import 'package:myplaces/features/search/repositories/photo_mapper.dart';
import 'package:myplaces/features/search/repositories/photo_repository.dart';

class _MockPhotoDataSource extends Mock implements IPhotoDataSource {}

void main() {
  group('PhotoRepository', () {
    test('maps results from the data source', () async {
      final dataSource = _MockPhotoDataSource();
      final repository = PhotoRepository(dataSource, PhotoMapper());

      when(() => dataSource.search('fontana di trevi')).thenAnswer(
        (_) async => {
          'results': [
            {
              'type': 'image_result',
              'properties': {'url': 'https://example.com/image.jpg'},
              'thumbnail': {'src': 'https://example.com/thumb.jpg'}
            }
          ],
        },
      );

      final result = await repository.search('fontana di trevi');

      expect(result, hasLength(1));
      expect(result.first, isA<PoiImage>());
      verify(() => dataSource.search('fontana di trevi')).called(1);
    });

    test('wraps client exceptions as PhotoFetchException', () async {
      final dataSource = _MockPhotoDataSource();
      final repository = PhotoRepository(dataSource, PhotoMapper());

      when(() => dataSource.search(any())).thenThrow(const FormatException());

      expect(repository.search('fontana di trevi'), throwsA(isA<PhotoFetchException>()));
    });
  });
}
