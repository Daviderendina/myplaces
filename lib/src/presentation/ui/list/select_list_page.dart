import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/domain/my_list.dart';
import 'package:myplaces/src/providers.dart';

import '../../../domain/poi.dart';
import '../common/circular_emoji_button.dart';

class SelectListPage extends ConsumerWidget {
  const SelectListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(listsControllerProvider)
        .when(
          data: (lists) {
            final poi = ref.watch(selectedPoiControllerProvider);

            if (poi == null) return SizedBox();

            return Scaffold(
              appBar: AppBar(title: Text("Select lists")),
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 14,
                ),
                child: Column(
                  children: lists.map((myList) {
                    bool listBelongsToPoi = poi.lists.any(
                      (l) => l.id == myList.id,
                    );

                    return Container(
                      margin: EdgeInsetsGeometry.all(4),
                      child: Material(
                        borderRadius: BorderRadius.circular(8),
                        child: InkWell(
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
                                    // color: listBelongsToPoi
                                    //     ? Colors.amber.withAlpha(40)
                                    //     : Colors.grey.withAlpha(40),
                                  ),
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: CircularEmojiButton(
                                      emoji: myList.emoji,
                                      isActive: listBelongsToPoi,
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
                                        fontWeight: listBelongsToPoi
                                            ? FontWeight.bold
                                            : FontWeight.w400,
                                        color: Colors.white.withAlpha(
                                          listBelongsToPoi ? 255 : 100,
                                        ),
                                        fontFamily: "Poppins",
                                      ),
                                    ),
                                    // Text(
                                    //   "${myList.poiList.length} places${myList.isArchived ? " · hidden" : ""}",
                                    //   textAlign: TextAlign.left,
                                    //   style: TextStyle(
                                    //     height: 1.2,
                                    //     fontSize: 14,
                                    //     color: Colors.white70.withAlpha(
                                    //       listBelongsToPoi ? 255 : 140,
                                    //     ),
                                    //     fontFamily: "Poppins",
                                    //   ),
                                    // ),
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
          },
          error: (_, _) => Text("ERROR"),
          loading: () => CircularProgressIndicator(),
        );
  }

  void onListClick(WidgetRef ref, MyList myList, Poi poi) async {
    final repo = ref.read(poiServiceProvider);
    Poi updatedPoi = await repo.togglePoiInList(poi, myList);

    // Update providers
    ref
        .read(selectedPoiControllerProvider.notifier)
        .selectNewPoi(updatedPoi.copy());
    //ref.read(myListsProvider.notifier).refresh(); // TODO non funziona!!!!
  }
}
