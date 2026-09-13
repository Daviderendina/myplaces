import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/features/collections/screens/select_collection_modal.dart';
import 'package:myplaces/features/map/controllers/main_map_state.dart';
import 'package:myplaces/features/map/providers.dart';

import '../../../../core/constants/AppLayout.dart';
import '../../../../core/constants/AppTheme.dart';
import '../../../../shared/widgets/button/icon_app_button.dart';

class SelectVisibleListsButton extends ConsumerWidget {
  final double size;

  const SelectVisibleListsButton({super.key, required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapState = ref.watch(mainMapControllerProvider).when(
      data: (state) => state,
      loading: () => const MainMapState(),
      error: (error, stackTrace) => const MainMapState(),
    );
    final selectedIds = mapState.visibleCollections.map((collection) => collection.id).toList();

    return IconAppButton.primary(
      icon: Icons.filter_list_outlined,
      buttonSize: size,
      iconSize: AppLayout.icons.medium,
      shape: IconAppShape.square,
      backgroundAlpha: AppTheme.surfaceAlpha,
      onPressed: () async {
        final result = await showModalBottomSheet<List<String>>(
          context: context,
          isScrollControlled: true,
          useSafeArea: true,
          backgroundColor: Colors.transparent,
          builder: (context) => SelectCollectionModal(
            initialCollectionIds: selectedIds,
            title: 'Mostra liste sulla mappa',
          ),
        );

        if (result != null) {
          await ref.read(mainMapControllerProvider.notifier).updateVisibleCollections(result);
        }
      },
    );
  }
}
