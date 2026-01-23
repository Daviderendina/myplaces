import 'package:flutter/cupertino.dart';
import 'package:myplaces/src/presentation/ui/common/my_title.dart';

class MainPageTitle extends StatelessWidget {
  final String text;

  const MainPageTitle({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: MyTitle(text: text),
    );
  }
}
