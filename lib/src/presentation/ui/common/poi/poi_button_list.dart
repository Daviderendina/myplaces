import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../functions/select_list_page/select_list_page.dart';
import '../../../../../models/my_list.dart';
import '../../../../../providers.dart';

class PoiButtonList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<MyList> allDefinedLists = ref.watch(myListsProvider);
    final poi = ref.watch(selectedPoiControllerProvider);

    List<MyList> defaultLists = allDefinedLists
        .where((l) => l.isDefault)
        .toList();

    final controller = ref.read(selectedPoiControllerProvider.notifier);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...defaultLists.map((list) {
          return IconButton(
            onPressed: () => controller.triggerPoiToList(poi, list),
            icon: Icon(
              Icons.question_mark_outlined,
              size: 30,
              color: controller.poiBelongToList(poi!, list)
                  ? Colors.amber
                  : Colors.grey,
            ),
          );
        }),

        SizedBox(width: 15),

        ActionChip(
          backgroundColor: Colors.lightBlue.withAlpha(30),
          onPressed: () {
            ref.read(selectedPoiProvider.notifier).state = poi;
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => SelectListPage()));
          },
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Add to list",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.lightBlue.shade200,
              ),
            ),
          ),
          avatar: Icon(Icons.add, color: Colors.lightBlue.shade200),
          elevation: 0,
          pressElevation: 0,
          shape: const StadiumBorder(
            side: BorderSide(color: Colors.transparent),
          ),
          padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
        ),
      ],
    );
  }
}
