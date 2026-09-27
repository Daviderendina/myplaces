import 'package:http/http.dart' as http;

import '../../../core/datasource/photo/IPhotoDataSource.dart';
import '../../../core/errors/app_exceptions.dart';
import '../../../core/models/poi_image.dart';
import '../../../core/repository/AbstractMapper.dart';
import '../../../logger.dart';

class PhotoRepository {
  final IPhotoDataSource _dataSource;
  final AbstractMapper<Map<String, dynamic>, List<PoiImage>> _mapper;

  PhotoRepository(this._dataSource, this._mapper);

  Future<List<PoiImage>> search(String query) async {
    try {
      final rawData = await _dataSource.search(query);
      return _mapper.map(rawData);
    } on AppException {
      rethrow;
    } on http.ClientException catch (e) {
      AppLogger.error('Error: $e | Response body: ${e.message}', PhotoRepository);
      throw const PhotoFetchException('The remote service is unavailable while fetching photos');
    } on FormatException catch (e) {
      AppLogger.error('FormatException: $e', PhotoRepository);
      throw const PhotoFetchException('The photo payload is not valid');
    } catch (e) {
      AppLogger.error('Unexpected error: $e', PhotoRepository);
      throw const PhotoFetchException('Unable to fetch POI photos');
    }
  }
}
