import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:org/screens/login_screen.dart';
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
              margin: EdgeInsets.symmetric(horizontal: 60, vertical: 40),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/siha-logo-v3.png'),
                ),
                borderRadius: BorderRadius.circular(60),
              ),
            ),
            FunctionalityWidget(
              icon: Icons.fastfood,
              text: 'Log Food  & Monitor Nutrition',
            ),
            FunctionalityWidget(
              icon: Icons.fitness_center,
              text: 'Get Lifestyle Recommendations',
            ),
            FunctionalityWidget(
              icon: Icons.insert_chart,
              text: 'Monitor Activity',
            ),
            GestureDetector(
              child: LoginButton(),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
