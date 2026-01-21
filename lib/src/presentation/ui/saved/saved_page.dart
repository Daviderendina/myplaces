import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/components/common/main_page_padding.dart';
import 'package:myplaces/components/common/main_page_subtitle.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/providers.dart';

import '../../../../components/common/main_page_title.dart';
import '../../../../components/saved_page/card_mylist_custom.dart';
import '../../../../components/saved_page/card_mylist_default.dart';
import '../../../../pages/list_page.dart';

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
                SizedBox(height: 60),

                MainPageTitle(text: "Saved"),

                SizedBox(height: 20),

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
                      label: Text(
                        "Add",
                        style: TextStyle(color: Colors.white54),
                      ),
                      avatar: Icon(Icons.add, color: Colors.white54),
                      onPressed: () => openNewListDialog(context, ref),
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
      ref.read(selectedListProvider.notifier).state = myList;

      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => ListPage()));
    };
  }

  Future openNewListDialog(BuildContext context, WidgetRef ref) {
    final nameController =
        TextEditingController(); // <- controller per il TextField

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create New List"),
        content: TextField(
          controller: nameController, // <-- qui
          autofocus: true,
          decoration: const InputDecoration(
            labelText: 'List name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // chiudi senza valore
            child: const Text("Cancel"),
          ),
          FilledButton(
            onPressed: () {
              final name = nameController.text.trim(); // <-- prendi il testo
              if (name.isEmpty) return; // non permettere save vuoto

              final newList = MyList(name: name);
              ref
                  .read(listsControllerProvider.notifier)
                  .addList(
                    newList,
                  ); // TODO gestire qui onError, devo mostrare il toast se la lista esiste gia - Se faccio in una page dedicata lo mostro direttamente sulla toast
              // TODO sarebbe carino mostrare un elemento in piu nella lista con loading!

              Navigator.pop(context); // chiudi il dialog
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
