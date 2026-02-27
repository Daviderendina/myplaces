import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myplaces/src/providers.dart';

import '../poi/poi_button_list.dart';
import '../poi/poi_detail_page.dart';
import '../../../../../src/domain/poi.dart';

class PoiBottomSheet extends ConsumerWidget {
  const PoiBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Poi? poi = ref.watch(selectedPoiControllerProvider);

    return poi == null
        ? SizedBox()
        : ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            child: Container(
              color: Colors.black.withAlpha(190),
              child: Stack(
                children: [
                  Container(
                    color: Colors.black54,
                    padding: EdgeInsets.only(top: 26, left: 33, right: 33),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          poi.name,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w500,
                            height: 1.2,
                          ),
                        ),
                        Text(
                          poi.getDisplayAreaName(),
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                          ),
                        ),

                        SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          height: 160,
                          child: (poi.images.isEmpty)
                              ? Center(child: Icon(Icons.not_interested))
                              : // Il Container che contiene la lista deve avere un'altezza definita
                                Container(
                                  //height: 180, // L'altezza che avevi già definito
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    // FONDAMENTALE: per lo scorrimento orizzontale
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    // Spazio ai lati dell'intera lista
                                    itemCount: poi.images.length,
                                    // Questo costruisce lo spazio tra un'immagine e l'altra
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 12),
                                    // Questo costruisce ogni singola "card" con l'immagine
                                    itemBuilder: (BuildContext context, int index) {
                                      final poiImage = poi.images[index];

                                      // Usiamo un SizedBox per dare una larghezza fissa a ogni elemento
                                      return SizedBox(
                                        //width: 280,
                                        // Larghezza di ogni card, puoi regolarla
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            12.0,
                                          ),
                                          // Angoli arrotondati
                                          child: Image.network(
                                            poiImage.thumbnail ?? "",
                                            fit: BoxFit.cover,
                                            // L'immagine riempie il contenitore
                                            // Gestione errori e caricamento (consigliato)
                                            loadingBuilder:
                                                (
                                                  context,
                                                  child,
                                                  loadingProgress,
                                                ) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Container(
                                                    color: Colors.grey.shade800,
                                                  );
                                                },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                                  return Container(
                                                    color: Colors.grey.shade800,
                                                    child: const Icon(
                                                      Icons.broken_image,
                                                      color: Colors.white54,
                                                    ),
                                                  );
                                                },
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                        ),

                        SizedBox(height: 20),

                        PoiButtonList(isBig: false),

                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          // TODO aggiornare riverpod
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => PoiDetailPage()),
                          ),
                          icon: Icon(Icons.fullscreen),
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
