import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myplaces/pages/saved_page.dart';
import 'package:myplaces/pages/profile_page.dart';
import 'package:myplaces/providers.dart';

import 'map_page.dart';

class RootPage extends ConsumerStatefulWidget {
  const RootPage({super.key});

  @override
  ConsumerState<RootPage> createState() => RootPageState();
}

class RootPageState extends ConsumerState<RootPage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [MapPage(), SavedPage(), ProfilePage()];

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (ref.watch(mapPageProvider).searchPoiResultToShow != null) {
          ref.read(mapPageProvider.notifier).clearMap();
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
                margin: EdgeInsets.only(bottom: 20),
                height: 70,
                width: 290,
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Color(0xff212329),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: GNav(
                  color: Colors.grey.shade600,
                  activeColor: Color(0xff907AE6),
                  tabBackgroundColor: Color(0xff907AE6).withAlpha(45),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  // padding interno alla label, deve essere 0 per le non selezionate e alto per le selezionate
                  tabBorderRadius: 22,
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
                      icon: Icons.person,
                      text: "Profile",
                      backgroundColor: Color(0x3cf89c74),
                      iconActiveColor: Color(0xdcf89c74),
                      textColor: Color(0xdcf89c74),
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onTabChange: (value) {
                    setState(() {
                      selectedIndex = value;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
