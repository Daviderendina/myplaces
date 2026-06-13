import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/collections/controllers/collections_state.dart';
import 'package:myplaces/shared/widgets/main_titled_screen.dart';
import '../models/collection.dart';
import '../providers.dart';

class CollectionsScreen extends ConsumerWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collectionsAsync = ref.watch(collectionsControllerProvider);

    return MainTitledScreen(
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

      action: IconButton(
        onPressed: () {
          // TODO add
        },
        icon: const Icon(Icons.add_circle_rounded),
      ),
      child: collectionsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Errore nel caricamento delle collezioni: $error'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.read(collectionsControllerProvider.notifier).refresh(),
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
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              List<Collection> collectionsToDisplay = collections.displayedCollections;
              final collection = collectionsToDisplay[index];

              return Row(
                children: [
                  CircleAvatar(
                    backgroundColor: collection.dominantEmojiColor.withAlpha(30),
                    child: Text(collection.emoji),
                  ),
                  const SizedBox(width: 8),
                  Text(collection.name, style: Theme.of(context).textTheme.titleMedium),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
