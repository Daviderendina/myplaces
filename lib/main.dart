import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/pages/root_page.dart';
import 'package:myplaces/providers.dart';

import 'objectbox.g.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final store = await openStore();

  runApp(
    ProviderScope(
      overrides: [objectBoxStoreProvider.overrideWithValue(store)],
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final init = ref.watch(appInitProvider);

    return init.when(
      loading: () => const CircularProgressIndicator(), // splash screen
      error: (e, st) => Text('Errore: $e'),
      data: (_) => MaterialApp(
        home: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.dark(),
          home: const RootPage(),
        ),
      ),
    );
  }
}
