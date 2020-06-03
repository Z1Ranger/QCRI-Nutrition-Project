import 'package:flutter/material.dart';
import 'package:org/constants.dart';

class FunctionalityWidget extends StatelessWidget {
  final image;
  final text;

  FunctionalityWidget({this.image, this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: CircleAvatar(
              backgroundColor: kCircular,
              radius: 35,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: kDimText,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
