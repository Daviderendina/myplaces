import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/domain/my_list.dart';
import 'package:myplaces/src/presentation/ui/map/select_visible_lists_popup_item.dart';
import '../../../providers.dart';

class SelectVisibleListsButton extends ConsumerWidget {
  const SelectVisibleListsButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listsAsync = ref.watch(listsControllerProvider);

    return GestureDetector(
      onTap: () async {
        final listsData = listsAsync.when(
          data: (data) => data,
          loading: () => [],
          error: (_, __) => [],
        );

        // posizione del menu rispetto al bottone
        final RenderBox button = context.findRenderObject() as RenderBox;
        final overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;
        final offset = button.localToGlobal(Offset.zero, ancestor: overlay);

        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            offset.dx,
            116, //offset.dy + button.size.height,
            68, //offset.dx + button.size.width + 100,
            offset.dy,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          clipBehavior: Clip.antiAlias,
          constraints: BoxConstraints(
            maxHeight: 300,
            minWidth: 1,
            maxWidth: 220,
          ),
          items: [
            PopupMenuItem(
              padding: EdgeInsets.zero,
              enabled: false,
              child: Material(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: listsData
                        .map(
                          (myList) => SelectListPopupItem(
                            myList: myList,
                            isEnabled: myList.visibleOnMap,
                            onChanged: (selected) {
                              (myList as MyList).setVisibleOnMap(selected);
                              ref
                                  .read(listsControllerProvider.notifier)
                                  .updateList(myList);
                            },
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ),
          ],
          elevation: 0,
        );
      },
      child: Container(
        height: 54,
        width: 54,
        decoration: BoxDecoration(
          color: Colors.teal.withAlpha(190),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(Icons.filter_list_outlined, color: Colors.white, size: 23),
      ),
    );
  }
}
