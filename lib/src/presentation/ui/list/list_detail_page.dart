import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart' hide Circle;
import 'package:myplaces/src/presentation/ui/common/main_page_subtitle.dart';
import 'package:myplaces/src/presentation/ui/list/select_list_page.dart';
import 'package:myplaces/src/presentation/ui/map/map_view.dart';
import 'package:myplaces/src/presentation/ui/poi/poi_card.dart';
import 'package:myplaces/src/providers.dart';

import '../../../domain/my_list.dart';
import '../../../domain/poi.dart';
import '../../../tools/extension/title_case_extension.dart';
import '../../../tools/logger.dart';
import '../common/my_title.dart';
import '../common/note/note_box.dart';
import '../common/note/note_dialog.dart';
import '../map/markers.dart';
import 'visual_symbol_visualizer.dart';
import '../poi/poi_detail_page.dart';
import 'list_information_full_dialog.dart';

class ListPage extends ConsumerStatefulWidget {
  const ListPage({super.key});

  @override
  ConsumerState<ListPage> createState() => _ListPageState();
}

class _ListPageState extends ConsumerState<ListPage> {
  late final FocusNode _focusNode;
  final MapController _mapController = MapController();
  LatLngBounds? _lastBounds;

  bool showNote = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myList = ref.watch(selectedListControllerProvider);
    if (myList == null) return const SizedBox();
    final poiList = myList.poiList;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.transparent,
        actions: [
          // TODO cancellare
          // if (myList.note.isEmpty)
          //   IconButton(
          //     icon: Icon(Icons.playlist_add, size: 20),
          //     onPressed: () => openNoteDialog(myList.note),
          //   ),
          //
          // SizedBox(width: 2),
          IconButton(
            icon: Icon(Icons.settings, size: 20),
            onPressed: () => showListInformationFullDialog(
              context,
              ListInformationAction.EDIT,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                MyTitle(text: myList.name.toTitleCase()),
                Spacer(),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: VisualSymbolVisualizer(
                        symbol: myList.visualSymbol,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 26),

            Row(
              children: [
                Expanded(
                  flex: myList.note.isEmpty ? 9 : 7,
                  child: SizedBox(
                    height: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: MapView(
                        controller: _mapController,
                        markerBuilder: () {
                          return myList.poiList
                              .map<Marker>(
                                (poi) => CircularFlagPoiMarker.build(
                                  poi: poi,
                                  onTap: () => openPoiDetailPage(poi, ref),
                                ),
                              )
                              .toList();
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                Expanded(
                  flex: myList.note.isEmpty ? 1 : 3,
                  child: myList.note.isEmpty
                      ? InkWell(
                          onTap: () => openNoteDialog(myList.note),
                          child: Container(
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(10),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(Icons.edit_note),
                          ),
                        )
                      : SizedBox(
                          height: 200,
                          child: NoteBox(
                            actualNote: myList.note,
                            onTap: () => openNoteDialog(myList.note),
                          ),
                        ),
                ),
              ],
            ),

            const SizedBox(height: 35),

            MainPageSubtitle(text: "Saved places"),
            const SizedBox(height: 10),

            Expanded(
              child: poiList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),

                      child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemCount: poiList.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 6),
                        itemBuilder: (context, index) {
                          final poi = poiList[index];
                          return PoiCard(
                            poi: poi,
                            onTap: () => openPoiDetailPage(poi, ref),
                            onSwipeLeft: () async {
                              await ref
                                  .read(selectedListControllerProvider.notifier)
                                  .deletePoiFromList(poi);
                            },
                            onSwipeRight: () {
                              ref
                                  .read(selectedPoiControllerProvider.notifier)
                                  .selectNewPoi(poi);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SelectListPage(),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    )
                  : const Center(child: Text("Empty list")),
            ),
          ],
        ),
      ),
    );
  }

  void openPoiDetailPage(Poi poi, WidgetRef ref) {
    // TODO sembra funzionare male quando lo apro da mappa
    ref.read(selectedPoiControllerProvider.notifier).selectNewPoi(poi);

    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => PoiDetailPage()));
  }

  void updateListNoteField(String value) {
    logger.info("Invoked updateListNoteField with value: $value");
    if (!_focusNode.hasFocus && value.trim().isEmpty) {
      setState(() {
        showNote = false;
      });
    }
    ref.read(selectedListControllerProvider.notifier).updateNote(value.trim());
    //ref.read(listsControllerProvider.notifier).refresh();
  }

  void openNoteDialog(String actualValue) {
    showNoteDialog(
      context,
      actualValue,
      (val) =>
          ref.read(selectedListControllerProvider.notifier).updateNote(val),
    );
  }
}
