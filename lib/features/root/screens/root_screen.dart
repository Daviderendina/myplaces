import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/core/constants/AppLayout.dart';
import 'package:myplaces/features/collections/screens/collection_list_screen.dart';
import 'package:myplaces/features/trips/screens/trips_screen.dart';
import '../../map/screens/main_map_screen.dart';
import '../provider.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO cambiare lo stile delle scritte della barra sotto
    final rootState = ref.watch(rootControllerProvider);
    final controller = ref.read(rootControllerProvider.notifier);

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      body: IndexedStack(
        index: rootState.selectedIndex,
        children: [
          //TODO const
          MainMapScreen(),
          CollectionsScreen(),
          TripsScreen(),
          Center(child: Text('Profile Screen')),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(
          AppLayout.geometry.pagePadding.left,
          0,
          AppLayout.geometry.pagePadding.right,
          AppLayout.geometry.pagePadding.right,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30), // TODO AppLAyout
          child: BottomNavigationBar(
            currentIndex: rootState.selectedIndex,
            onTap: (index) => controller.setIndex(index),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.map_outlined),
                activeIcon: Icon(Icons.map),
                label: 'Map',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                activeIcon: Icon(Icons.bookmark_rounded),
                label: 'Collections',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore),
                label: 'Trips',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
