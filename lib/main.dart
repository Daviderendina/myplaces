import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:latlong2/latlong.dart';
import 'package:myplaces/pages/root_page.dart';

import 'mygnav.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: RootPage(),
    );
  }
}
