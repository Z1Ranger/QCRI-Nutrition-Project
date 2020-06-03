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
            Expanded(
              child: Container(
                height: 150,
                margin: EdgeInsets.symmetric(horizontal: 50, vertical: 35),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        image: DecorationImage(
                            image: AssetImage('images/logo.png'),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 50, right: 50, top: 50),
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: kDimText,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Enter Name Here',
                    ),
                    autofocus: false,
                  )),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 50, right: 50),
                  child: TextField(
                    decoration: InputDecoration(
                      fillColor: kDimText,
                      filled: true,
                      border: OutlineInputBorder(),
                      hintText: 'Enter Password Here',
                    ),
                    autofocus: false,
                  )),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4, vertical: 15),
                child: GestureDetector(
                  child: LoginButton(),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoggedInHome()),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
