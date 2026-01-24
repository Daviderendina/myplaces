import 'dart:math';

import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart' hide Circle;
import 'package:myplaces/src/presentation/ui/common/main_page_subtitle.dart';
import 'package:myplaces/src/presentation/ui/common/note_box.dart';
import 'package:myplaces/src/presentation/ui/poi/poi_card.dart';
import 'package:myplaces/src/providers.dart';

import '../../../domain/my_list.dart';
import '../../../domain/poi.dart';
import '../../../tools/extension/title_case_extension.dart';
import '../../../tools/logger.dart';
import '../common/circular_icon_button.dart';
import '../common/my_subtitle.dart';
import '../poi/poi_detail_page.dart';

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
      appBar: AppBar(toolbarHeight: 60, backgroundColor: Colors.transparent),
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    MainPageSubtitle(text: myList.name.toTitleCase()),
                    Spacer(),
                    if (myList.note.isEmpty && !showNote)
                      CircularIconButton(
                        icon: Icons.playlist_add,
                        onPressed: addNoteOnTap,
                      ),
                    SizedBox(width: 2),
                    CircularIconButton(icon: Icons.settings, onPressed: () {}),
                  ],
                ),

                SizedBox(height: 26),

                SizedBox(
                  height: 200,
                  width: double.infinity,
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
                              (poi) => Marker(
                                point: poi.coordinates,
                                child: GestureDetector(
                                  onTap: () => openPoiDetailPage(poi, ref),
                                  child: Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black12),
                                      borderRadius: BorderRadius.circular(30),
                                      color: Colors.black.withAlpha(180),
                                    ),
                                    child: CountryFlag.fromCountryCode(
                                      poi.countrycode ?? '',
                                      theme: const ImageTheme(shape: Circle()),
                                    ), //Icon(Icons.star),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 15),

                if (myList.note.isNotEmpty || showNote) ...[
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: NoteBox(
                      actualNote: myList.note,
                      focusNode: _focusNode,
                      onSubmitted: updateListNoteField,
                    ),
                  ),
                ],

                const SizedBox(height: 20),

                Expanded(
                  child: poiList.isNotEmpty
                      ? ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: poiList.length,
                          separatorBuilder: (_, _) => const SizedBox(height: 6),
                          itemBuilder: (context, index) {
                            final poi = poiList[index];
                            return PoiCard(
                              poi: poi,
                              onTap: () => openPoiDetailPage(poi, ref),
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

  // TODO tutti questi metodi vanno in un controller ad hoc!!!
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
  }

  // TODO usare questi metodi per size dinamica dei poi
  // double markerSizeFromZoom(double zoom) {
  //   return (pow(1.2, zoom - 10) * 6).clamp(6.0, 28.0);
  // }
  // double borderWidthFromZoom(double zoom) {
  //   return (zoom / 20).clamp(0.5, 2.5);
  // }
}
