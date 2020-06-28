import 'package:flutter/material.dart';
import 'package:org/constants.dart';

class MealCard extends StatelessWidget {
  final meal;
  final amount;
  final navigate;

  MealCard({this.meal, this.amount, this.navigate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[Text(meal), Text(amount)],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
        divider,
        GestureDetector(
          onTap: navigate,
          child: Container(
            child: Row(
              children: <Widget>[
                Icon(Icons.add),
                SizedBox(
                  width: 10,
                ),
                Text('Add Food')
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
        ),
      ],
    );
  }
}
