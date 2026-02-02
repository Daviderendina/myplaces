import 'package:flutter/material.dart';
import 'package:myplaces/src/domain/my_list.dart';

import '../../../domain/default_lists.dart';
import 'visual_symbol_visualizer.dart';

class CardMylistDefault extends StatelessWidget {
  final MyList myList;
  final VoidCallback onTap;

  const CardMylistDefault({
    super.key,
    required this.myList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          width: 120,
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 6),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.yellow.shade800.withAlpha(210),
                  //TODO sistemare, piu che altro in caso farlo colorato bisogna capire da dove prendere il colore
                  borderRadius: BorderRadius.circular(22),
                  //shape: BoxShape.circle,
                ),
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Center(
                      child: VisualSymbolVisualizer(
                        symbol: myList.visualSymbol,
                        forceWhite: true,
                      ),
                    ),
                  ),
                  // child: CircularEmojiButton(
                  //   emoji: myList.emoji,
                  //   isActive: listBelongsToPoi,
                  // ),
                ),
              ),
              SizedBox(height: 12),
              Text(
                myList.displayName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Poppins",
                ),
              ),
              Text(
                "${myList.poiList.length} places",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  fontFamily: "Poppins",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
