import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';

import '../../../domain/poi.dart';

class PoiCard extends StatelessWidget {
  final Poi poi;
  final VoidCallback onTap;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;

  const PoiCard({
    super.key,
    required this.poi,
    required this.onTap,
    required this.onSwipeLeft,
    required this.onSwipeRight,
  });

  @override
  Widget build(BuildContext context) {
    // TODO mettere snackbar per annullare cancellazione
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Dismissible(
        key: ValueKey(poi.id),
        direction: DismissDirection.horizontal,
        background: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.red.withAlpha(190),
          ),
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(Icons.delete, color: Colors.white),
        ),
        secondaryBackground: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.withAlpha(190),
          ),
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Icon(Icons.playlist_add, color: Colors.white),
        ),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            onSwipeLeft.call();
            return true;
          } else if (direction == DismissDirection.endToStart) {
            onSwipeRight.call();
            return false;
          }
        },
        // onDismissed: (direction) {
        //   onSwipeLeft.call();
        // },
        // child: ClipRRect(
        //   borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(poi.category.asset, fit: BoxFit.cover),
              ),

              // Optional overlay (per leggibilità testo)
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.35)),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(poi.name),
                        Spacer(),
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: CountryFlag.fromCountryCode(
                            poi.countrycode ?? '',
                            theme: const ImageTheme(shape: Circle()),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      poi.getDisplayAreaName(),
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
