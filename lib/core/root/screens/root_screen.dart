import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../provider.dart';

class RootScreen extends ConsumerWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rootState = ref.watch(rootControllerProvider);
    final controller = ref.read(rootControllerProvider.notifier);

    final bottomNavBarMargin = 24.0;

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: rootState.selectedIndex,
        children: const [
          Center(child: Text('Map Screen')),
          Center(child: Text('Collections Screen')),
          Center(child: Text('Trips Screen')),
          Center(child: Text('Profile Screen')),
        ],
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.fromLTRB(bottomNavBarMargin, 0, bottomNavBarMargin, bottomNavBarMargin),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            currentIndex: rootState.selectedIndex,
            onTap: (index) => controller.changePage(index),
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
                icon: Icon(Icons.place_outlined),
                activeIcon: Icon(Icons.place),
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
