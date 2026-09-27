import 'package:flutter_test/flutter_test.dart';
import 'package:myplaces/features/search/repositories/photo_mapper.dart';

void main() {
  group('PhotoMapper', () {
    test('maps valid Brave results into poi images', () {
      final mapper = PhotoMapper();

      final result = mapper.map({
        'results': [
          {
            'type': 'image_result',
            'properties': {
              'url': 'https://example.com/image.jpg',
              'placeholder': 'https://example.com/thumb-placeholder.jpg',
            },
            'thumbnail': {'src': 'https://example.com/thumb.jpg'}
          }
        ],
      });

      expect(result, hasLength(1));
      expect(result.first.url, 'https://example.com/image.jpg');
      expect(result.first.thumbnailUrl, 'https://example.com/thumb.jpg');
    });

    test('falls back to placeholder thumbnail when src is missing', () {
      final mapper = PhotoMapper();

      final result = mapper.map({
        'results': [
          {
            'type': 'image_result',
            'properties': {
              'url': 'https://example.com/image.jpg',
              'placeholder': 'https://example.com/thumb-placeholder.jpg',
            },
            'thumbnail': {}
          }
        ],
      });

      expect(result.first.thumbnailUrl, 'https://example.com/thumb-placeholder.jpg');
    });

    test('returns empty list when results are missing or invalid', () {
      final mapper = PhotoMapper();

      expect(mapper.map({'results': []}), isEmpty);
      expect(mapper.map(<String, dynamic>{}), isEmpty);
      expect(mapper.map({'results': 'invalid'}), isEmpty);
    });
  });
}
