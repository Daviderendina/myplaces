import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myplaces/features/collections/models/collection.dart';
import 'package:myplaces/features/collections/screens/collection_detail_screen.dart';
import 'package:myplaces/features/poi/screens/poi_detail_screen.dart';
import 'package:myplaces/features/root/screens/root_screen.dart';
import 'package:myplaces/core/models/poi.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

// TODO fare delle costanti per i path

class AppRouter {
  static final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const RootScreen()),
      GoRoute(
        path: '/collection-detail',
        builder: (context, state) {
          final collection = state.extra as Collection;
          return CollectionDetailScreen(collection: collection);
        },
      ),
      GoRoute(
        path: '/poi-detail',
        builder: (context, state) {
          final poi = state.extra as Poi?;
          return PoiDetailScreen(poi: poi);
        },
      ),
    ],
  );
}
