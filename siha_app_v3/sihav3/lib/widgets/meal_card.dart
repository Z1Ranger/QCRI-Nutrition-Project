import 'package:flutter/material.dart';
import 'package:org/constants.dart';

class MealCard extends StatelessWidget {
  final meal;
  final amount;
  final navigate;
  final data;

  MealCard({this.meal, this.amount, this.navigate, this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                meal,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text('Calories: $amount')
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.only(top: 10, bottom: 2, left: 10, right: 10),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(data[index]['food']),
                  Text(data[index]['nutrients']['cals'].toString())
                ],
              ),
              margin: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
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
