import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/domain/my_list.dart';
import 'package:myplaces/src/providers.dart';

class CardMylistCustom extends ConsumerWidget {
  final MyList myList;
  final VoidCallback onTap;

  const CardMylistCustom({
    super.key,
    required this.myList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsetsGeometry.all(4),
      child: Material(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 48,
                  height: 48,
                  child: Center(
                    child: Text(myList.emoji, style: TextStyle(fontSize: 26)),
                  ),
                ),
                SizedBox(width: 14),
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
                        color: Colors.white,
                        fontFamily: "Poppins",
                      ),
                    ),
                    Text(
                      "${myList.poiList.length} places${myList.isArchived ? " · hidden" : ""}",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 14,
                        color: Colors.white70,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
                Spacer(),

                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == "edit") {
                      // codice edit
                    } else if (value == "delete") {
                      ref
                          .read(listsControllerProvider.notifier)
                          .removeList(myList);
                      ref.read(listsControllerProvider.notifier).refresh();
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: "edit",
                      child: Row(
                        children: const [
                          Icon(Icons.edit),
                          SizedBox(width: 10),
                          Text("Edit"),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: "delete",
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          Icon(Icons.delete),
                          SizedBox(width: 10),
                          Text("Delete"),
                        ],
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
  }
}
