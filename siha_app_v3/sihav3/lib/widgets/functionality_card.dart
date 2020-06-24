import 'package:flutter/material.dart';
import 'package:org/constants.dart';

class FunctionalityCard extends StatelessWidget {
  final color;
  final icon;
  final text;
  final subtext;
  final view;

  FunctionalityCard(
      {this.icon, this.color, this.text, this.subtext, this.view});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        child: ListTile(
          leading: Icon(
            icon,
            size: 35,
            color: color,
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(color: color, fontSize: 18),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              subtext,
              style: TextStyle(color: Colors.grey, fontSize: 15),
            ),
          ),
          onTap: view,
        ),
      ),
    );
  }
}
