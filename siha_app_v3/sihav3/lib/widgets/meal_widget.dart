import 'package:flutter/material.dart';
import 'package:org/constants.dart';

class MealWidget extends StatelessWidget {
  final image;
  final meal;
  final color;

  MealWidget({this.image, this.meal, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.asset(
            image,
            height: 125,
            width: 125,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              meal,
              style: TextStyle(color: kMainTheme, fontSize: 20),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
    );
  }
}
