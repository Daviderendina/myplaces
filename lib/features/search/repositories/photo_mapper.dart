import '../../../core/models/poi_image.dart';
import '../../../core/repository/AbstractMapper.dart';

class PhotoMapper extends AbstractMapper<Map<String, dynamic>, List<PoiImage>> {
  @override
  List<PoiImage> map(Map<String, dynamic> data) {
    final results = data['results'];
    if (results is! List) {
      return const [];
    }

    final images = <PoiImage>[];
    for (final result in results) {
      if (result is! Map<String, dynamic>) continue;
      if (result['type'] != 'image_result') continue;

      final properties = result['properties'];
      if (properties is! Map) continue;
      final propertiesMap = Map<String, dynamic>.from(properties);

      final url = propertiesMap['url'];
      if (url is! String || url.trim().isEmpty) continue;

      final thumbnail = result['thumbnail'];
      String thumbnailUrl = '';
      if (thumbnail is Map) {
        final thumbnailMap = Map<String, dynamic>.from(thumbnail);
        final thumbnailSrc = thumbnailMap['src'];
        if (thumbnailSrc is String && thumbnailSrc.trim().isNotEmpty) {
          thumbnailUrl = thumbnailSrc.trim();
        }
      }

      if (thumbnailUrl.isEmpty) {
        final placeholder = propertiesMap['placeholder'];
        if (placeholder is String && placeholder.trim().isNotEmpty) {
          thumbnailUrl = placeholder.trim();
        }
      }

      images.add(PoiImage(url: url.trim(), thumbnailUrl: thumbnailUrl));
    }

    return images;
  }
}
