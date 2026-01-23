import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/presentation/ui/root/root_page.dart';
import 'package:myplaces/src/providers.dart';

import '../objectbox.g.dart';

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
          theme: appTheme(),
          home: const RootPage(),
        ),
      ),
    );
  }

  ThemeData appTheme() {
    return ThemeData.dark(useMaterial3: true).copyWith(
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      dividerColor: Colors.transparent, // rimuove linee tra le tile
      expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: Colors.transparent,
        collapsedBackgroundColor: Colors.transparent,
        childrenPadding: EdgeInsets.zero,
        collapsedShape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
    );
  }
}
