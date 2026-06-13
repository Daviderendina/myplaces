import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppTheme.dart';
import 'package:myplaces/core/root/screens/root_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: AppTheme.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: RootScreen()),
    );
    // TODO
    // final init = ref.watch(appInitProvider);
    //
    // return init.when(
    //   loading: () => const MaterialApp(
    //     home: Scaffold(body: Center(child: CircularProgressIndicator())),
    //   ),
    //   error: (e, st) => MaterialApp(
    //     home: Scaffold(body: Center(child: Text('Errore: $e'))),
    //   ),
    //   data: (_) => MaterialApp(
    //     title: 'Flutter Demo',
    //     home: Center(child: const Text("Hello, world")),
    //   ),
    // );
  }
}
