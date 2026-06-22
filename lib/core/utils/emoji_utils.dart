import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class EmojiUtils {
  static Future<Color> getColorFromEmoji(String emoji) async {
    // 1. Configurazione del recorder
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final textPainter = TextPainter(
      text: TextSpan(
        text: emoji,
        style: const TextStyle(fontSize: 100), // Dimensione grande per precisione
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, Offset.zero);

    // 2. Trasforma in immagine
    final picture = recorder.endRecording();
    final img = await picture.toImage(textPainter.width.toInt(), textPainter.height.toInt());

    // 3. Converti in ByteData per PaletteGenerator
    final byteData = await img.toByteData(format: ui.ImageByteFormat.png);
    final pngBytes = byteData!.buffer.asUint8List();

    // 4. Usa PaletteGenerator
    final paletteGenerator = await PaletteGenerator.fromImageProvider(MemoryImage(pngBytes));

    return paletteGenerator.dominantColor?.color ?? Colors.grey;
  }
}
