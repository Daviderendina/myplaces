import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:myplaces/pages/places_page.dart';
import 'package:myplaces/pages/profile_page.dart';

import 'map_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<StatefulWidget> createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  int selectedIndex = 1;
  
  @override
  Widget build(BuildContext context) {
    List pages = [null, MapPage(), PlacesPage(), ProfilePage()];

    return Scaffold(
      body: Stack(
        children: [
          // Todo: spostare questo in una MapPage
          pages[selectedIndex],

          // Align(
          //   alignment: AlignmentGeometry.topCenter,
          //   child: Padding(
          //     padding: EdgeInsetsGeometry.only(top: 50, left: 20, right: 20),
          //     child: SearchBar(leading: Icon(Icons.search)),
          //   ),
          // ),
          Align(
            alignment: AlignmentGeometry.bottomCenter,
            child: Container(
              margin: EdgeInsets.only(bottom: 20),
              height: 70,
              width: 390,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Color(0xff212329),
                borderRadius: BorderRadius.circular(22),
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
                  GButton(icon: Icons.search, text: "Search"),
                  GButton(icon: Icons.map, text: "Map"),
                  GButton(icon: Icons.place_outlined, text: "Places"),
                  GButton(icon: Icons.person, text: "Profile"),
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
    );
  }
}
