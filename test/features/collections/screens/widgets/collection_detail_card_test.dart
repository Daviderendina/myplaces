import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:myplaces/core/models/poi.dart';
import 'package:myplaces/features/collections/screens/widgets/collection_detail_card.dart';

void main() {
  testWidgets('CollectionDetailCard displays poi name and coordinates', (WidgetTester tester) async {
    final poi = Poi(
      id: '1',
      name: 'Test POI',
      coordinates: const Coordinates(latitude: 45.0, longitude: 9.0),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CollectionDetailCard(poi: poi),
        ),
      ),
    );

    expect(find.text('Test POI'), findsOneWidget);
    expect(find.textContaining('Lat: 45.0000'), findsOneWidget);
    expect(find.byType(Row), findsOneWidget);
  });
}
