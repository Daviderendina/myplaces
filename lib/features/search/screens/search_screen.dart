import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/search/providers.dart';
import 'package:myplaces/features/search/screens/widgets/search_result_tile.dart';
import 'package:myplaces/shared/widgets/layout/app_search_bar_container.dart';
import 'package:myplaces/src/domain/poi.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resultsAsync = ref.watch(searchControllerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppLayout.geometry.pagePadding.left,
              ),
              child: Column(
                children: [
                  SizedBox(height: AppLayout.spaces.verticalSmall),
                  AppSearchBarContainer(
                    controller: _textController,
                    autofocus: true,
                    height: AppLayout.geometry.itemHeightSmall,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainer.withAlpha(100),
                    // TODO sistemare qui
                    readOnly: false,
                    leading: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).hintColor,
                    ),
                    hintText: 'Search..',
                    onChanged: (value) {
                      setState(() {});
                      ref
                          .read(searchControllerProvider.notifier)
                          .onQueryChanged(value);
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: resultsAsync.when(
              data: (pois) {
                if (pois.isEmpty && _textController.text.isNotEmpty) {
                  return const Center(child: Text('No results found'));
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: pois.length,
                  itemBuilder: (context, index) {
                    final poi = pois[index];
                    return _buildPoiTile(context, poi);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoiTile(BuildContext context, Poi poi) {
    return SearchResultTile(
      title: poi.name,
      subtitle: poi.getDisplayAreaName(),
      icon: Icons.location_on,
      onTap: () {
        context.pop(poi);
      },
    );
  }
}
