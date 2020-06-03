import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:org/widgets/functionality_widget.dart';
import 'package:org/widgets/login_button.dart';
import 'package:org/constants.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainTheme,
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 60, vertical: 50),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/logo.png'),
                ),
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            FunctionalityWidget(
              image: 'images/calorie.png',
              text: 'LOG FOOD  & MONITOR CALORIES',
            ),
            FunctionalityWidget(
              image: 'images/health.png',
              text: 'GET LIFESTYLE RECOMMENDATIONS',
            ),
            FunctionalityWidget(
              image: 'images/watch.png',
              text: 'MONITOR ALL ACTIVITY DEVICES IN ONE PLACE',
            ),
            Expanded(
              child: LoginButton(),
            ),
          ],
        ),
      ),
    );
  }
}
