import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: EdgeInsets.symmetric(horizontal: 70, vertical: 30),
      alignment: Alignment.center,
      child: Text(
        'LOGIN',
        style: TextStyle(fontSize: 15),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFF828DFD),
              Color(0xFFA5C4FF),
              Color(0xFFCEE0FF),
              Color(0xFFFFFFFF),
            ]),
      ),
    );
  }
}
