import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:myplaces/components/list_page/poi_card.dart';
import 'package:myplaces/extension/title_case_extension.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/models/poi_image.dart';
import 'package:myplaces/src/presentation/ui/poi_detail/poi_detail_page.dart';
import 'package:myplaces/providers.dart';

import '../../../../components/common/main_page_title.dart';
import '../../../../models/poi.dart';
import '../common/chips.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({super.key});

  @override
  ConsumerState<ListPage> createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage> {
  late final TextEditingController _textEditingController;
  late final FocusNode _focusNode;

  bool showNote = false;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _focusNode = FocusNode();

    // _focusNode.addListener(() {
    //   if (!_focusNode.hasFocus && _textEditingController.text.trim().isEmpty) {
    //     setState(() {
    //       showNote = false;
    //     });
    //   }
    // });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myList = ref.watch(selectedListControllerProvider);

    if (myList == null) return const SizedBox();

    final poiList = myList.poiList;

    if (_textEditingController.text != myList.note) {
      _textEditingController.text = myList.note;
    }

    return Scaffold(
      appBar: AppBar(toolbarHeight: 60, backgroundColor: Colors.transparent),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainPageTitle(text: myList.name.toTitleCase()),

                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      const SizedBox(width: 4),
                      MyActionChip(title: "Map", icon: Icons.map, onTap: () {}),

                      if (!myList.isDefault) ...[
                        const SizedBox(width: 4),
                        MyFilterChip(
                          title: myList.isArchived ? 'Hidden' : 'Showed',
                          icon: myList.isArchived
                              ? Icons.visibility_off
                              : Icons.visibility,
                          selected: myList.isArchived,
                          onSelected: (v) => updateListVisibility(v),
                          selectedColor: Colors.green,
                        ),
                      ],

                      if (myList.note.isEmpty && !showNote) ...[
                        const SizedBox(width: 4),
                        MyActionChip(
                          title: "Add note",
                          icon: Icons.playlist_add,
                          onTap: addNoteOnTap,
                        ),
                      ],
                    ],
                  ),
                ),

                if (myList.note.isNotEmpty || showNote) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _textEditingController,
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Colors.white38,
                            width: 0.7,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                          borderSide: BorderSide(
                            color: Colors.white10,
                            width: 0.5,
                          ),
                        ),
                      ),
                      onSubmitted: updateListNoteField,
                      onTapOutside: (_) {
                        updateListNoteField(_textEditingController.text);
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                Expanded(
                  child: poiList.isNotEmpty
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: poiList.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 6),
                          itemBuilder: (context, index) {
                            final poi = poiList[index];
                            return PoiCard(
                              poi: poi,
                              onTap: () {
                                ref
                                    .read(
                                      selectedPoiControllerProvider.notifier,
                                    )
                                    .selectNewPoi(poi);
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => PoiDetailPage(poi: poi),
                                  ),
                                );
                              },
                              onDismissed: () {
                                // ref
                                //     .read(
                                //       selectedListControllerProvider.notifier,
                                //     )
                                //     .deletePoiFromList();
                                // TODO cancello dalla lista
                                // TODO refresh del provider prima
                              },
                            );
                          },
                        )
                      : const Center(child: Text("Empty list")),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> updateListVisibility(bool value) async {
    await ref
        .read(selectedListControllerProvider.notifier)
        .setListVisibility(value);
    ref.invalidate(listsControllerProvider);
  }

  void addNoteOnTap() {
    setState(() {
      showNote = true;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void updateListNoteField(String value) {
    if (!_focusNode.hasFocus && value.trim().isEmpty) {
      setState(() {
        showNote = false;
      });
    }
    ref.read(selectedListControllerProvider.notifier).updateNote(value.trim());
  }
}
