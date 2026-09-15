import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/search/controllers/search_controller.dart';
import 'package:myplaces/features/search/repositories/search_mapper.dart';
import 'package:myplaces/features/search/repositories/search_repository.dart';
import 'package:myplaces/features/search/services/search_service.dart';
import 'package:myplaces/shared/datasource/poi/IPoiDataSource.dart';
import 'package:myplaces/shared/datasource/poi/NominatingDataSource.dart';

import 'model/PoiSearchResult.dart';

final poiDataSourceProvider = Provider<IPoiDataSource>((ref) {
  return NominatingDataSource();
});

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final dataSource = ref.watch(poiDataSourceProvider);
  return SearchRepository(dataSource, SearchMapper());
});

final searchServiceProvider = Provider<SearchService>((ref) {
  final repository = ref.watch(searchRepositoryProvider);
  return SearchService(repository);
});

final searchControllerProvider = AsyncNotifierProvider<SearchController, List<PoiSearchResult>>(() {
  return SearchController();
});
