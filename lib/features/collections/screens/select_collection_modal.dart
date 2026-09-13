import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/collections/models/collection.dart';
import 'package:myplaces/features/collections/providers.dart';
import 'package:myplaces/features/collections/screens/widgets/collection_list_tile.dart';
import 'package:myplaces/shared/widgets/button/text_app_button.dart';
import 'package:myplaces/shared/widgets/modal/base_fullscreen_modal.dart';

class SelectCollectionModal extends ConsumerStatefulWidget {
  final List<String> initialCollectionIds;
  final String title;

  const SelectCollectionModal({
    super.key,
    required this.initialCollectionIds,
    required this.title,
  });

  @override
  ConsumerState<SelectCollectionModal> createState() => _SelectCollectionModalState();
}

class _SelectCollectionModalState extends ConsumerState<SelectCollectionModal> {
  late Set<String> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = widget.initialCollectionIds.toSet();
  }

  void _toggleCollection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final collectionsAsync = ref.watch(collectionsControllerProvider);
    final collections = collectionsAsync.when(
      data: (state) => state.allCollections,
      loading: () => const <Collection>[],
      error: (error, stackTrace) => const <Collection>[],
    );

    return BaseFullscreenModal(
      title: widget.title,
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: collections.length,
              separatorBuilder: (context, index) =>
                  SizedBox(height: AppLayout.spaces.verticalSmall),
              itemBuilder: (context, index) {
                final collection = collections[index];
                final isSelected = _selectedIds.contains(collection.id);

                return CollectionListTile(
                  collection: collection,
                  isDisabled: !isSelected,
                  onPressed: () => _toggleCollection(collection.id),
                );
              },
            ),
          ),
          SizedBox(height: AppLayout.spaces.verticalLarge),
          TextAppButton(
            text: 'Save',
            onPressed: () => Navigator.pop(context, _selectedIds.toList()),
          ),
        ],
      ),
    );
  }
}
