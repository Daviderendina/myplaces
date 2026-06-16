import 'package:flutter/cupertino.dart';
import 'package:myplaces/shared/widgets/layout/secondary_titled_screen.dart';

class CollectionDetailScreen extends StatelessWidget {
  // TODO accetta una Collection
  const CollectionDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryTitledScreen(title: "Title", subtitle: "Subtitle", child: Text("data"));
  }
}
