import 'package:flutter/material.dart';
import 'package:org/screens/loggedin_home.dart';
import 'package:org/widgets/login_button.dart';
import 'package:org/constants.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainTheme,
      appBar: AppBar(
        backgroundColor: kMainTheme,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 35),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(60),
                      image: DecorationImage(
                          image: AssetImage('images/siha-logo-v3.png'),
                          fit: BoxFit.cover)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white, //Font color change
                ),
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(color: Colors.white10),
                    labelText: 'Username',
                    labelStyle: TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                style: TextStyle(
                  color: Colors.white,
                  decorationColor: Colors.white, //Font color change
                ),
                decoration: const InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.white,
                    ),
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.white10),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
              child: GestureDetector(
                child: LoginButton(),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoggedInHome()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
