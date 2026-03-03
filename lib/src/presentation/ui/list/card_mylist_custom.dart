import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/domain/my_list.dart';
import 'package:myplaces/src/providers.dart';

import 'visual_symbol_visualizer.dart';

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
            padding: const EdgeInsets.only(
              left: 18,
              top: 10,
              bottom: 10,
              right: 18,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 50,
                  height: 50,
                  child: VisualSymbolVisualizer(symbol: myList.visualSymbol),
                ),
                SizedBox(width: 20),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 240),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        myList.displayName,
                        textAlign: TextAlign.left,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          height: 1.3,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: "Poppins",
                        ),
                      ),
                      Text(
                        "${myList.poiList.length} places",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 15,
                          color: Colors.white70,
                          fontFamily: "Poppins",
                        ),
                      ),
                    ],
                  ),
                ),

                Spacer(),
                if (myList.isArchived)
                  Icon(Icons.visibility_off_outlined, color: Colors.white54),

                // SizedBox(width: 4),
                // PopupMenuButton<String>(
                //   onSelected: (value) {
                //     if (value == "edit") {
                //       // codice edit
                //     } else if (value == "delete") {
                //       ref
                //           .read(listsControllerProvider.notifier)
                //           .removeList(myList);
                //       ref
                //           .read(listsControllerProvider.notifier)
                //           .refresh(); // TODO perchè qui refresh??
                //     }
                //   },
                //   itemBuilder: (context) => [
                //     PopupMenuItem(
                //       value: "edit",
                //       child: Row(
                //         children: const [
                //           Icon(Icons.edit),
                //           SizedBox(width: 10),
                //           Text("Edit"),
                //         ],
                //       ),
                //     ),
                //     PopupMenuItem(
                //       value: "delete",
                //       child: Row(
                //         crossAxisAlignment: CrossAxisAlignment.end,
                //         children: const [
                //           Icon(Icons.delete),
                //           SizedBox(width: 10),
                //           Text("Delete"),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
