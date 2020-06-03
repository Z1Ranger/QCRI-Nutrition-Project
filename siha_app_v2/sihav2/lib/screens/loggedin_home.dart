import 'package:flutter/material.dart';
import 'package:org/constants.dart';
import 'package:org/screens/food_logging_overview.dart';
import 'package:org/widgets/functionality_widget.dart';
import 'package:org/screens/user_page.dart';

class LoggedInHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainTheme,
        title: Image.asset(
          kAppBarLogo,
          height: 100,
          width: 100,
        ),
        centerTitle: true,
        actions: <Widget>[
          // action button
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserPage()),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 55, horizontal: 35),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: kMainTheme),
              child: FlatButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodLoggingOverview()),
                ),
                child: FunctionalityWidget(
                  image: 'images/calorie.png',
                  text: 'LOG FOOD  & MONITOR CALORIES',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 55, horizontal: 35),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: kMainTheme),
              child: FlatButton(
                onPressed: () {},
                child: FunctionalityWidget(
                  image: 'images/health.png',
                  text: 'GET LIFESTYLE RECOMMENDATIONS',
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 55, horizontal: 35),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: kMainTheme),
              child: FlatButton(
                onPressed: () {},
                child: FunctionalityWidget(
                  image: 'images/watch.png',
                  text: 'MONITOR ALL ACTIVITY DEVICES IN ONE PLACE',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
