import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/search/controllers/search_controller.dart';
import 'package:myplaces/features/search/repositories/search_mapper.dart';
import 'package:myplaces/features/search/repositories/search_repository.dart';
import 'package:myplaces/features/search/services/search_service.dart';
import 'package:myplaces/features/search/repositories/poi_details_mapper.dart';

import '../../core/datasource/poi/IPoiDataSource.dart';
import '../../core/datasource/poi/NominatingDataSource.dart';
import 'model/PoiSearchResult.dart';

final poiDataSourceProvider = Provider<IPoiDataSource>((ref) {
  return NominatingDataSource();
});

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final dataSource = ref.watch(poiDataSourceProvider);
  return SearchRepository(dataSource, SearchMapper(), PoiDetailsMapper());
});

final searchServiceProvider = Provider<SearchService>((ref) {
  final repository = ref.watch(searchRepositoryProvider);
  return SearchService(repository);
});

final searchControllerProvider = AsyncNotifierProvider<SearchController, List<PoiSearchResult>>(() {
  return SearchController();
});
