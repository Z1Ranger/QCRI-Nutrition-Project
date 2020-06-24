import 'package:flutter/material.dart';
import 'package:org/constants.dart';
import 'package:org/screens/coming_soon.dart';
import 'package:org/screens/discover.dart';
import 'package:org/screens/food_logging_overview.dart';
import 'package:org/widgets/functionality_card.dart';
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FunctionalityCard(
              icon: Icons.local_dining,
              color: kMainTheme,
              text: 'Track Food',
              subtext: 'Log Food & Monitor Calories',
              view: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FoodLoggingOverview()),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FunctionalityCard(
              color: kMainTheme,
              icon: Icons.speaker_notes,
              text: 'Lifestyle Recommendations',
              subtext: 'Get Lifestyle Recommendations from experts',
              view: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DiscoverPage()),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: FunctionalityCard(
              icon: Icons.insert_chart,
              color: kMainTheme,
              text: 'Monitor Activity',
              subtext: 'Monitor all the activity in one place',
              view: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ComingSoon()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
