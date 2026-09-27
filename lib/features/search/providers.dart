import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/datasource/photo/BravePhotoDataSource.dart';
import 'package:myplaces/core/datasource/photo/IPhotoDataSource.dart';
import 'package:myplaces/features/search/controllers/search_controller.dart';
import 'package:myplaces/features/search/repositories/photo_mapper.dart';
import 'package:myplaces/features/search/repositories/photo_repository.dart';
import 'package:myplaces/features/search/repositories/search_mapper.dart';
import 'package:myplaces/features/search/repositories/search_repository.dart';
import 'package:myplaces/features/search/services/search_service.dart';
import 'package:myplaces/features/search/repositories/poi_details_mapper.dart';

import '../../core/datasource/poi/IPoiDataSource.dart';
import '../../core/datasource/poi/NominatingDataSource.dart';
import 'model/PoiPreview.dart';

final poiDataSourceProvider = Provider<IPoiDataSource>((ref) {
  return NominatingDataSource();
});

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final dataSource = ref.watch(poiDataSourceProvider);
  return SearchRepository(dataSource, SearchMapper(), PoiDetailsMapper());
});

final photoDataSourceProvider = Provider<IPhotoDataSource>((ref) {
  return BravePhotoDataSource();
});

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  final dataSource = ref.watch(photoDataSourceProvider);
  return PhotoRepository(dataSource, PhotoMapper());
});

final searchServiceProvider = Provider<SearchService>((ref) {
  final repository = ref.watch(searchRepositoryProvider);
  final photoRepository = ref.watch(photoRepositoryProvider);
  return SearchService(repository, photoRepository);
});

final searchControllerProvider = AsyncNotifierProvider<SearchController, List<PoiPreview>>(() {
  return SearchController();
});
