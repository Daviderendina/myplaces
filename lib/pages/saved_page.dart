import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/components/common/page_title.dart';
import 'package:myplaces/models/my_list.dart';
import 'package:myplaces/providers.dart';

import '../components/saved_page/card_mylist_custom.dart';
import '../components/common/page_subtitle.dart';
import '../components/saved_page/card_mylist_default.dart';
import 'list_page.dart';

class SavedPage extends ConsumerWidget {
  const SavedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(savedPageProvider);

    return state.when(
      error: (e, _) => Text('Errore: $e'),
      loading: () => const CircularProgressIndicator(),
      data: (myLists) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60),
              PageTitle(text: "Saved"),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: myLists
                    .where((l) => l.isDefault)
                    .map(
                      (myList) => CardMylistDefault(
                        myList: myList,
                        onTap: openListDetail(context, myList),
                      ),
                    )
                    .toList(),
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  PageSubtitle(text: "My Lists"),
                  Spacer(),
                  IconButton(
                    onPressed: () => openNewListDialog(context, ref),
                    icon: Icon(Icons.add),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: myLists
                      .where((l) => !l.isDefault)
                      .map(
                        (myList) => CardMylistCustom(
                          myList: myList,
                          onTap: openListDetail(context, myList),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 100),
            ],
          ),
        );
      },
    );
  }

  VoidCallback openListDetail(BuildContext context, MyList myList) {
    return () {
      Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (context) => ListPage(myList: myList)));
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
                  .read(savedPageProvider.notifier)
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
