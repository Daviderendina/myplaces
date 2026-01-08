import 'package:flutter/material.dart';
import 'package:myplaces/models/list_element.dart';
import 'package:myplaces/models/my_list.dart';

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
                  color: Color(0xffd39e1d), //TODO sistemare
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.question_mark, color: Colors.white, size: 32),
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
