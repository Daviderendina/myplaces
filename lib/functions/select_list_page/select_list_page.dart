import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/providers.dart';

import '../../models/poi.dart';

class SelectListPage extends ConsumerWidget {
  const SelectListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MyList> allDefinedLists = ref.watch(myListsProvider);
    final poi = ref.watch(selectedPoiProvider);
    print("POI LISTS: ${poi?.lists.length}");

    if (poi == null) return SizedBox();

    return Scaffold(
      appBar: AppBar(title: Text("Select lists")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: allDefinedLists.map((myList) {
            bool listBelongsToPoi = poi.lists.any((l) => l.id == myList.id);

            return Container(
              margin: EdgeInsetsGeometry.all(4),
              child: Material(
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => onListClick(ref, myList, poi),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: listBelongsToPoi
                                ? Colors.amber.withAlpha(40)
                                : Colors.grey.withAlpha(40),
                          ),
                          child: SizedBox(
                            width: 48,
                            height: 48,
                            child: Icon(
                              Icons.question_mark,
                              color: listBelongsToPoi
                                  ? Colors.amber
                                  : Colors.grey,
                              size: 24,
                            ),
                          ),
                        ),
                        SizedBox(width: 24),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              myList.displayName,
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                height: 1.2,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withAlpha(
                                  listBelongsToPoi ? 255 : 140,
                                ),
                                fontFamily: "Poppins",
                              ),
                            ),
                            Text(
                              "${myList.poiList.length} places${myList.isArchived ? " · hidden" : ""}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                height: 1.2,
                                fontSize: 14,
                                color: Colors.white70.withAlpha(
                                  listBelongsToPoi ? 255 : 140,
                                ),
                                fontFamily: "Poppins",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void onListClick(WidgetRef ref, MyList myList, Poi poi) {
    final repo = ref.read(poiRepositoryProvider);
    Poi updatedPoi = repo.togglePoiInList(poi, myList);

    // Update providers
    ref.read(selectedPoiProvider.notifier).state = updatedPoi.copy();
    ref.invalidate(myListsProvider);
  }
}
