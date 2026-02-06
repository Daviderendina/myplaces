import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart' hide Circle;
import 'package:myplaces/src/presentation/ui/common/main_page_subtitle.dart';
import 'package:myplaces/src/presentation/ui/common/my_subtitle.dart';
import 'package:myplaces/src/presentation/ui/list/select_list_page.dart';
import 'package:myplaces/src/presentation/ui/poi/poi_card.dart';
import 'package:myplaces/src/providers.dart';

import '../../../domain/my_list.dart';
import '../../../domain/poi.dart';
import '../../../tools/extension/title_case_extension.dart';
import '../../../tools/logger.dart';
import '../common/circular_icon_button.dart';
import '../common/my_title.dart';
import '../common/note/note_box.dart';
import '../common/note/note_dialog.dart';
import 'visual_symbol_visualizer.dart';
import '../poi/poi_detail_page.dart';
import 'circular_flag_poi_marker.dart';
import 'edit_list_dialog.dart';

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

    calculateMapPosition(myList);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.transparent,
        actions: [
          if (myList.note.isEmpty)
            IconButton(
              icon: Icon(Icons.playlist_add, size: 20),
              onPressed: () => openNoteDialog(myList.note),
            ),
          if (!myList.isDefault) ...[
            SizedBox(width: 2),
            IconButton(
              icon: Icon(Icons.settings, size: 20),
              onPressed: () => showEditListFullDialog(context),
            ),
          ],
        ],
      ),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 12,
                  children: [
                    MyTitle(text: myList.name.toTitleCase()),
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
                          child: FlutterMap(
                            mapController: _mapController,
                            options: const MapOptions(initialZoom: 5),
                            children: [
                              TileLayer(
                                urlTemplate:
                                    'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                                subdomains: const ['a', 'b', 'c', 'd'],
                                userAgentPackageName: 'it.drendina.myplaces',
                              ),
                              MarkerLayer(
                                markers: [
                                  ...myList.poiList.map(
                                    (poi) => CircularFlagPoiMarker.build(
                                      poi: poi,
                                      onTap: () => openPoiDetailPage(poi, ref),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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

                MainPageSubtitle(text: "Places ${myList.poiList.length}"),
                const SizedBox(height: 10),

                Expanded(
                  child: poiList.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),

                          // GRIGLIA
                          // child: GridView.builder(
                          //   physics: const BouncingScrollPhysics(),
                          //   itemCount: poiList.length,
                          //   gridDelegate:
                          //       const SliverGridDelegateWithFixedCrossAxisCount(
                          //         crossAxisCount: 2, // 2 colonne
                          //         mainAxisSpacing: 6, // spacing verticale
                          //         crossAxisSpacing: 6, // spacing orizzontale
                          //         childAspectRatio:
                          //             3 /
                          //             2, // rapporto larghezza/altezza della card (modifica a piacere)
                          //       ),
                          //   itemBuilder: (context, index) {
                          //     final poi = poiList[index];
                          //     return PoiCard(
                          //       poi: poi,
                          //       onTap: () => openPoiDetailPage(poi, ref),
                          //       onDismissed: () {
                          //         // TODO cancello dalla lista
                          //         // TODO refresh del provider prima
                          //       },
                          //     );
                          //   },
                          // ),
                          //
                          // LISTA
                          child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemCount: poiList.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 6),
                            itemBuilder: (context, index) {
                              final poi = poiList[index];
                              return PoiCard(
                                poi: poi,
                                onTap: () => openPoiDetailPage(poi, ref),
                                onSwipeLeft: () async {
                                  await ref
                                      .read(
                                        selectedListControllerProvider.notifier,
                                      )
                                      .deletePoiFromList(poi);
                                  ref
                                      .read(listsControllerProvider.notifier)
                                      .refresh(); // TODO ha senso farlo qui o meglio tenere la dipendenza dentro riverpod?
                                },
                                onSwipeRight: () {
                                  ref
                                      .read(
                                        selectedPoiControllerProvider.notifier,
                                      )
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
        ],
      ),
    );
  }

  void calculateMapPosition(MyList myList) {
    LatLngBounds boundsFromPoints(Iterable<LatLng> points) {
      final iterator = points.iterator;

      if (!iterator.moveNext()) {
        throw ArgumentError('points must not be empty');
      }

      var minLat = iterator.current.latitude;
      var maxLat = iterator.current.latitude;
      var minLng = iterator.current.longitude;
      var maxLng = iterator.current.longitude;

      while (iterator.moveNext()) {
        final p = iterator.current;
        minLat = min(minLat, p.latitude);
        maxLat = max(maxLat, p.latitude);
        minLng = min(minLng, p.longitude);
        maxLng = max(maxLng, p.longitude);
      }

      return LatLngBounds(LatLng(minLat, minLng), LatLng(maxLat, maxLng));
    }

    final points = myList.poiList.map((l) => l.coordinates).toList();
    final LatLngBounds? newBounds = myList.poiList.length >= 2
        ? boundsFromPoints(points)
        : null;
    if (newBounds != null && newBounds != _lastBounds) {
      _lastBounds = newBounds;

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController.fitCamera(
          CameraFit.bounds(
            bounds: newBounds,
            padding: const EdgeInsets.all(48),
            maxZoom: 16,
          ),
        );
      });
    }
    if (myList.poiList.length == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _mapController.move(points.first, 15);
      });
    }
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
    ref.read(listsControllerProvider.notifier).refresh();
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
