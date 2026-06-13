import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/presentation/ui/common/main_page_padding.dart';
import 'package:myplaces/src/presentation/ui/common/main_page_subtitle.dart';
import 'package:myplaces/src/domain/my_list.dart';
import 'package:myplaces/src/providers.dart';

import '../common/main_page_title.dart';
import '../list/card_mylist_custom.dart';
import '../list/card_mylist_default.dart';
import '../list/list_detail_page.dart';
import 'list_information_full_dialog.dart';

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => SavedPageState();
}

class SavedPageState extends ConsumerState<SavedPage> {
  bool hiddenListsVisibility = false;

  @override
  Widget build(BuildContext context) {
    final lists = ref.watch(listsControllerProvider);

    return lists.when(
      error: (e, _) => Text('Errore: $e'),
      loading: () => const CircularProgressIndicator(),
      data: (myLists) {
        return SingleChildScrollView(
          child: MainPagePadding(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainPageTitle(text: "Saved"),

                // TODO questa logica del default va spostata da qui! non è il widget a decidere cosa è default e cosa no
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: myLists
                      .where((l) => l.isDefault)
                      .map(
                        (myList) => CardMylistDefault(
                          myList: myList,
                          onTap: openListDetail(context, ref, myList),
                        ),
                      )
                      .toList(),
                ),

                SizedBox(height: 30),

                Row(
                  children: [
                    MainPageSubtitle(text: "My Lists"),
                    Spacer(),
                    ActionChip(
                      // TODO cambiare stile
                      label: Text(
                        "Add",
                        style: TextStyle(color: Colors.white54),
                      ),
                      avatar: Icon(Icons.add, color: Colors.white54),
                      onPressed: () => showListInformationFullDialog(
                        context,
                        ListInformationAction.CREATE,
                      ),
                      elevation: 0,
                      pressElevation: 0,
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.white10),
                      ),
                      padding: EdgeInsetsGeometry.symmetric(horizontal: 5),
                      backgroundColor: Colors.yellow.withAlpha(0),
                    ),
                    SizedBox(width: 4),
                    FilterChip(
                      selected: hiddenListsVisibility,
                      selectedColor: Colors.amber.shade900,
                      showCheckmark: false,
                      label: Icon(
                        hiddenListsVisibility
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 20,
                      ),
                      onSelected: (value) => setState(() {
                        hiddenListsVisibility = !hiddenListsVisibility;
                      }),
                      padding: EdgeInsetsGeometry.symmetric(
                        vertical: 0,
                        horizontal: 5,
                      ),
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.white10),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                Column(
                  spacing: 6,
                  children: myLists
                      .where((l) => !l.isDefault)
                      .where(
                        (l) =>
                            (hiddenListsVisibility) ||
                            (!hiddenListsVisibility && !l.isArchived),
                      )
                      .map(
                        (myList) => CardMylistCustom(
                          myList: myList,
                          onTap: openListDetail(context, ref, myList),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        );
      },
    );
  }

  VoidCallback openListDetail(
    BuildContext context,
    WidgetRef ref,
    MyList myList,
  ) {
    return () {
      ref.read(selectedListControllerProvider.notifier).selectNewList(myList);

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => ListPage()));
    };
  }

  // TODO gestire onError sulla creazione di una lista, devo mostrare il toast se la lista esiste gia - Se faccio in una page dedicata lo mostro direttamente sulla toast
  // TODO sarebbe carino mostrare un elemento in piu nella lista con loading!
}
