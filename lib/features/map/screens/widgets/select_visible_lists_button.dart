import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/domain/my_list.dart';
import 'package:myplaces/features/map/screens/widgets/select_visible_lists_popup_item.dart';
import '../../../../core/constants/AppLayout.dart';
import '../../../../core/constants/AppTheme.dart';
import '../../../../shared/widgets/button/icon_app_button.dart';
import '../../../../src/providers.dart';

class SelectVisibleListsButton extends ConsumerWidget {
  final double size;

  const SelectVisibleListsButton({super.key, required this.size});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listsAsync = ref.watch(listsControllerProvider);
    // TODO menu

    return GestureDetector(
      onTap: () async {
        // ... (resto del codice invariato fino a showMenu)
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
          constraints: const BoxConstraints(
            maxHeight: 220,
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
      child: IconAppButton.primary(
        icon: Icons.filter_list_outlined,
        buttonSize: size,
        iconSize: AppLayout.icons.medium,
        shape: IconAppShape.square,
        backgroundAlpha: AppTheme.surfaceAlpha,
        onPressed: () {},
      ),
    );
  }
}
