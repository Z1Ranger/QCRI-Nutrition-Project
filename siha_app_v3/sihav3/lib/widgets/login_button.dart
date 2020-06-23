import 'package:flutter/material.dart';
import 'package:org/constants.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 70, vertical: 30),
      alignment: Alignment.center,
      child: Text(
        'Log In',
        style: TextStyle(
          fontSize: 20,
          color: kMainTheme,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
    );
  }
}
