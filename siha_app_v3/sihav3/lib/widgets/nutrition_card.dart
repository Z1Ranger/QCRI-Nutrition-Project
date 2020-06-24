import 'package:flutter/material.dart';

class NutritionCard extends StatelessWidget {
  NutritionCard({this.image, this.value, this.description, this.color});

  final image;
  final String value;
  final String description;
  final color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            height: 40,
            width: 40,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              style: TextStyle(fontSize: 40, color: color),
            ),
          ),
          Text(
            description,
            style: TextStyle(fontSize: 15, color: Colors.grey),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 3),
    );
  }
}
