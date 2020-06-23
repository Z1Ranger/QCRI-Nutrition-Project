import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularNutritionIndicator extends StatelessWidget {
  final color;
  final nutrition;
  final text;

  CircularNutritionIndicator({this.color, this.nutrition, this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularPercentIndicator(
          radius: 60.0,
          lineWidth: 5.0,
          percent: 1.0,
          center: new Text(text),
          progressColor: color,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(nutrition),
        )
      ],
    );
  }
}
