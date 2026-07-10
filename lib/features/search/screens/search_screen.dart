import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/search/providers.dart';
import 'package:myplaces/features/search/screens/widgets/search_result_tile.dart';
import 'package:myplaces/shared/widgets/app_search_bar_container.dart';
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
                horizontal: AppLayout.geometry.mainPagePadding.left,
              ),
              child: Column(
                children: [
                  SizedBox(height: AppLayout.spaces.verticalSmall),
                  AppSearchBar(
                    controller: _textController,
                    autofocus: true,
                    height: AppLayout.geometry.itemHeightSmall,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerLow,
                    readOnly: false,
                    leading: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).hintColor,
                    ),
                    onLeadingTap: () {
                      ref
                          .read(searchControllerProvider.notifier)
                          .clearResults();
                      Navigator.pop(context);
                    },
                    trailing: _textController.text.isNotEmpty
                        ? Icon(Icons.close, color: Theme.of(context).hintColor)
                        : null,
                    onTrailingTap: () {
                      _textController.clear();
                      ref
                          .read(searchControllerProvider.notifier)
                          .clearResults();
                      setState(() {});
                    },
                    hintText: 'Search..',
                    onChanged: (value) {
                      ref
                          .read(searchControllerProvider.notifier)
                          .onQueryChanged(value);
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: resultsAsync.when(
              data: (pois) {
                if (resultsAsync.isLoading || resultsAsync.isRefreshing) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (pois.isEmpty && _textController.text.trim().isNotEmpty) {
                  return const Center(child: Text('No results found'));
                }
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: pois.length,
                  itemBuilder: (context, index) {
                    final poi = pois[index];
                    return SearchResultTile(
                      title: poi.name,
                      subtitle: poi.getDisplayAreaName(),
                      icon: Icons.location_on,
                      onTap: () {
                        context.pop(poi);
                      },
                    );
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
}
