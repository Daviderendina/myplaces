import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/search/providers.dart';
import 'package:myplaces/features/search/controllers/search_controller.dart';
import 'package:myplaces/src/domain/poi.dart';

void main() {
  group('SearchController Tests', () {
    test('Initial state is empty list', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final state = await container.read(searchControllerProvider.future);
      expect(state, isEmpty);
    });

    test('onQueryChanged triggers search after debounce', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(searchControllerProvider.notifier);
      
      controller.onQueryChanged('Mario');
      
      // Wait for debounce (500ms) + network delay (300ms)
      await Future.delayed(const Duration(milliseconds: 1000));
      
      final state = container.read(searchControllerProvider);
      
      expect(state.value, isNotEmpty);
      expect(state.value!.first.name, contains('Mario'));
    });

    test('onQueryChanged with empty string resets state', () async {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final controller = container.read(searchControllerProvider.notifier);
      
      controller.onQueryChanged('Mario');
      await Future.delayed(const Duration(milliseconds: 1000));
      
      controller.onQueryChanged('');
      
      final state = container.read(searchControllerProvider);
      expect(state.value, isEmpty);
    });
  });
}
