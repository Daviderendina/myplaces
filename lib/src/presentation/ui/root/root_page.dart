import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myplaces/src/presentation/ui/profile/profile_page.dart';
import 'package:myplaces/src/providers.dart';

import '../list/saved_page.dart';
import '../map/map_page.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key});

  @override
  ConsumerState<RootPage> createState() => RootPageState();
}

class RootPageState extends ConsumerState<RootPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      MapPage(),
      SavedPage(),
      ProfilePage(),
      ProfilePage(),
    ];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (ref.watch(mapPageControllerProvider).showPoiMarker) {
          ref.read(mapPageControllerProvider.notifier).clearMap();
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.black.withValues(alpha: 80),
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: Stack(
          children: [
            pages[selectedIndex],

            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(bottom: 18),
                height: 65,
                width: 384,
                padding: EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(220),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GNav(
                  color: Colors.grey.shade600,
                  activeColor: Color(0xff907AE6),
                  tabBackgroundColor: Color(0xff907AE6).withAlpha(45),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  tabBorderRadius: 10,
                  iconSize: 32,
                  haptic: true,
                  gap: 10,
                  tabs: [
                    GButton(
                      icon: Icons.map,
                      text: "Map",
                      backgroundColor: Color(0x3c66c5cc),
                      iconActiveColor: Color(0xdc66c5cc),
                      textColor: Color(0xdc66c5cc),
                    ),
                    GButton(
                      icon: Icons.bookmark_border_outlined,
                      text: "Saved",
                      backgroundColor: Color(0x3cf6cf71),
                      iconActiveColor: Color(0xdcf6cf71),
                      textColor: Color(0xdcf6cf71),
                    ),
                    GButton(
                      icon: Icons.travel_explore,
                      text: "Trips",
                      backgroundColor: Color(0x3cf6cf71),
                      iconActiveColor: Color(0xdcf6cf71),
                      textColor: Color(0xdcf6cf71),
                    ),
                    GButton(
                      icon: Icons.person,
                      text: "Profile",
                      backgroundColor: Color(0x3cf89c74),
                      iconActiveColor: Color(0xdcf89c74),
                      textColor: Color(0xdcf89c74),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onTabChange: changePage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void changePage(int index) {
    if (selectedIndex == 0) {
      // map page
      ref.read(mapPageControllerProvider.notifier).clearMap();
    }
    setState(() {
      selectedIndex = index;
    });
  }
}
