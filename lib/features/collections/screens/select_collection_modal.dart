import 'package:flutter/material.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/collections/models/collection.dart';
import 'package:myplaces/features/collections/models/emoji.dart';
import 'package:myplaces/features/collections/screens/widgets/collection_list_tile.dart';
import 'package:myplaces/shared/widgets/modal/base_fullscreen_modal.dart';
import 'package:myplaces/shared/widgets/large_button.dart';

class SelectCollectionModal extends StatefulWidget {
  final List<String> initialCollectionIds;

  const SelectCollectionModal({
    super.key,
    required this.initialCollectionIds,
  });

  @override
  State<SelectCollectionModal> createState() => _SelectCollectionModalState();
}

class _SelectCollectionModalState extends State<SelectCollectionModal> {
  late Set<String> _selectedIds;

  // Mocked data for collections
  final List<Collection> _mockedCollections = [
    Collection(
      id: '1',
      name: 'Preferiti',
      emoji: MyEmoji(value: '⭐', color: Colors.amber),
      pois: [],
    ),
    Collection(
      id: '2',
      name: 'Da visitare',
      emoji: MyEmoji(value: '📍', color: Colors.red),
      pois: [],
    ),
    Collection(
      id: '3',
      name: 'Viaggio Estate',
      emoji: MyEmoji(value: '🏖️', color: Colors.blue),
      pois: [],
    ),
    Collection(
      id: '4',
      name: 'Ristoranti',
      emoji: MyEmoji(value: '🍝', color: Colors.orange),
      pois: [],
    ),
  ];

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
    return BaseFullscreenModal(
      title: 'Salva in una collezione',
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: _mockedCollections.length,
              separatorBuilder: (context, index) => SizedBox(
                height: AppLayout.getSmallVerticalSpace(context),
              ),
              itemBuilder: (context, index) {
                final collection = _mockedCollections[index];
                final isSelected = _selectedIds.contains(collection.id);

                return CollectionListTile(
                  collection: collection,
                  isDisabled: !isSelected,
                  onPressed: () => _toggleCollection(collection.id),
                );
              },
            ),
          ),
          SizedBox(height: AppLayout.getMediumVerticalSpace(context)),
          LargeButton(
            text: 'Save',
            onPressed: () {
              // Logic for saving selection will go here
              Navigator.pop(context, _selectedIds.toList());
            },
          ),
        ],
      ),
    );
  }
}
