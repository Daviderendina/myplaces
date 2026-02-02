import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/visual_symbol.dart';

class VisualSymbolVisualizer extends StatelessWidget {
  final VisualSymbol symbol;
  final bool colored;
  final bool forceWhite;

  const VisualSymbolVisualizer({
    super.key,
    required this.symbol,
    this.colored = true,
    this.forceWhite = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        fit: BoxFit.contain,
        child: symbol.isIcon
            ? Icon(
                symbol.icon!,
                color: forceWhite
                    ? Colors.white
                    : colored
                    ? symbol.iconColor
                    : Colors.white.withAlpha(70),
              )
            : Text(
                symbol.emoji!,
                style: TextStyle(
                  fontSize: 22,
                  color: forceWhite
                      ? Colors.white
                      : Colors.white.withAlpha(colored ? 255 : 70),
                ),
              ),
      ),
    );
  }
}
