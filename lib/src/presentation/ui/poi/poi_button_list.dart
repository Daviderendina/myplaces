import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/default_lists.dart';
import '../../../tools/logger.dart';
import '../list/select_list_page.dart';
import '../../../providers.dart';
import '../../../domain/my_list.dart';

class PoiButtonList extends ConsumerWidget {
  const PoiButtonList({super.key});

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
              spacing: 4,
              children: [
                ...defaultLists.map((myList) {
                  DefaultListType type = DefaultListType.fromName(myList.name);

                  return IconButton(
                    onPressed: () => controller.triggerPoiToList(poi, myList),
                    icon: Icon(
                      type.icon,
                      size: 30,
                      color: controller.poiBelongToList(poi!, myList)
                          ? type.color
                          : Colors.grey,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add to list",
                      style: TextStyle(
                        fontSize: 20,
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
