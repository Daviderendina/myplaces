import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/search/controllers/search_controller.dart';
import 'package:myplaces/features/search/datasources/search_datasource.dart';
import 'package:myplaces/features/search/repositories/search_repository.dart';
import 'package:myplaces/features/search/services/search_service.dart';
import 'package:myplaces/src/domain/poi.dart';

final searchDataSourceProvider = Provider<SearchDataSource>((ref) {
  return MockSearchDataSource();
});

final searchRepositoryProvider = Provider<SearchRepository>((ref) {
  final dataSource = ref.watch(searchDataSourceProvider);
  return SearchRepository(dataSource);
});

final searchServiceProvider = Provider<SearchService>((ref) {
  final repository = ref.watch(searchRepositoryProvider);
  return SearchService(repository);
});

final searchControllerProvider = AsyncNotifierProvider<SearchController, List<Poi>>(() {
  return SearchController();
});
