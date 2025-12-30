import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myplaces/models/list_element.dart';

class ListCircleCard extends StatelessWidget {
  final PlacesList listElement;
  final int placesNumber;

  const ListCircleCard({
    super.key,
    required this.listElement,
    required this.placesNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          print("Card cliccata");
        },
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
                  color: listElement.color,
                  shape: BoxShape.circle,
                ),
                child: Icon(listElement.icon, color: Colors.white, size: 32),
              ),
              SizedBox(height: 12),
              Text(
                listElement.label,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Poppins",
                ),
              ),
              Text(
                "$placesNumber luoghi",
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
