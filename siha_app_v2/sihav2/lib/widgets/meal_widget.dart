import 'package:flutter/material.dart';
import 'package:org/constants.dart';

class MealWidget extends StatelessWidget {
  final image;
  final meal;

  MealWidget({this.image, this.meal});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 125,
          width: 125,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
            ),
          ),
          child: Container(
            margin: EdgeInsets.only(top: 80),
            decoration: BoxDecoration(
              color: kDimPink,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            meal,
            style: TextStyle(color: kMainTheme, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
