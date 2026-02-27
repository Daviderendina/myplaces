import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/default_lists.dart';
import '../../../tools/logger.dart';
import '../list/visual_symbol_visualizer.dart';
import '../list/select_list_page.dart';
import '../../../providers.dart';
import '../../../domain/my_list.dart';

class PoiButtonList extends ConsumerWidget {
  final bool isBig;

  const PoiButtonList({super.key, this.isBig = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    logger.debug(">>> Loading PoiButtonList widget");

    return ref
        .watch(listsControllerProvider)
        .when(
          data: (lists) {
            final poi = ref.watch(selectedPoiControllerProvider);

            List<MyList> defaultLists = lists
                .where((l) => l.isDefault)
                .toList();

            final controller = ref.read(selectedPoiControllerProvider.notifier);

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: isBig ? 4 : 0,
              children: [
                ...defaultLists.map((myList) {
                  return IconButton(
                    onPressed: () => controller.triggerPoiToList(poi, myList),
                    icon: SizedBox(
                      height: isBig ? 30 : 28,
                      width: isBig ? 30 : 28,
                      child: Center(
                        child: VisualSymbolVisualizer(
                          symbol: myList.visualSymbol,
                          colored: poi!.lists
                              .map((l) => l.id)
                              .toList()
                              .contains(myList.id),
                        ),
                      ),
                    ),
                  );
                }),

                SizedBox(width: 15),

                ActionChip(
                  backgroundColor: Colors.yellow.withAlpha(30),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SelectListPage()),
                    );
                  },
                  label: Padding(
                    padding: EdgeInsets.all(isBig ? 8 : 6),
                    child: Text(
                      "Add to list",
                      style: TextStyle(
                        fontSize: isBig ? 20 : 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.yellow.shade800,
                      ),
                    ),
                  ),
                  avatar: Icon(Icons.add, color: Colors.yellow.shade800),
                  elevation: 0,
                  pressElevation: 0,
                  shape: const StadiumBorder(
                    side: BorderSide(color: Colors.transparent),
                  ),
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
                ),
              ],
            );
          },
          error: (_, _) => Text("ERROR"),
          loading: () => CircularProgressIndicator(),
        );
  }
}
