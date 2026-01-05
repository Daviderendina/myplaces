import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myplaces/config/categories_icon.dart';

import '../../models/poi.dart';

class PoiResultCard extends StatelessWidget {
  final Poi poi;
  final VoidCallback onTap;

  const PoiResultCard({super.key, required this.poi, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(4),
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.black,
          ),
          child: Row(
            children: [
              Icon(getIconForPoi(poi), color: Colors.grey.shade400),
              const SizedBox(width: 18),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 260,
                    child: Text(
                      poi.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: 260,
                    child: Text(
                      poi.getDisplayAreaName(),
                      style: TextStyle(color: Colors.grey.shade500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
