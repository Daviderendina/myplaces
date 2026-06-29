import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/collections/controllers/collections_state.dart';
import 'package:myplaces/features/collections/screens/add_collection_modal.dart';
import 'package:myplaces/features/collections/screens/widgets/collection_list_tile.dart';
import 'package:myplaces/shared/widgets/app_search_bar.dart';
import 'package:myplaces/shared/widgets/button/circular_icon_button.dart';
import 'package:myplaces/shared/widgets/layout/main_titled_screen.dart';
import '../providers.dart';

class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionsAsync = ref.watch(collectionsControllerProvider);

    return SafeArea(
      child: MainTitledScreen(
        title: 'Collections',
        subtitle: collectionsAsync.when(
          error: (error, stackTrace) => "",
          loading: () {
            return "Skeleton";
          },
          data: (CollectionsState data) => data.isFiltered
              ? "${data.displayedCollections.length} collections found"
              : "${data.allCollections.length} collections saved",
        ),
        action: CircularIconButton.primary(
          icon: Icons.add,
          size: AppLayout.button.getCircularMediumSize(context),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              backgroundColor: Colors.transparent,
              builder: (context) => AddCollectionModal(),
            );
          },
        ),
        searchBar: GenericSearchBar(
          hintText: 'Cerca collezioni...',
          onSearch: (query) {
            ref.read(collectionsControllerProvider.notifier).filter(query);
          },
        ),
        child: collectionsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Errore: $error'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {},
                  //=> ref.read(collectionsControllerProvider.notifier).refresh(),
                  child: const Text('Riprova'),
                ),
              ],
            ),
          ),
          data: (CollectionsState collections) {
            if (collections.displayedCollections.isEmpty) {
              return const Center(child: Text('Nessuna collezione trovata.'));
            }

            return ListView.separated(
              //padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), TODO fare qualcosa in comune con l'altra
              itemCount: collections.displayedCollections.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppLayout.space.getVerticalSmall(context)),
              itemBuilder: (context, index) {
                final collection = collections.displayedCollections[index];

                return CollectionListTile(
                  collection: collection,
                  //isDisabled: true,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
