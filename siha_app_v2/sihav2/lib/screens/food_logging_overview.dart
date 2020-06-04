import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:org/screens/meal_log.dart';
import 'user_page.dart';
import 'package:org/constants.dart';
import 'package:org/widgets/circular_nutritional_indicator.dart';
import 'discover.dart';

bool experiencedUser = false;

class FoodLoggingOverview extends StatefulWidget {
  @override
  _FoodLoggingOverviewState createState() => _FoodLoggingOverviewState();
}

class _FoodLoggingOverviewState extends State<FoodLoggingOverview> {
  DateTime _dateTime = DateTime.now();

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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserPage()),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MealLog()),
        ),
        tooltip: 'Add food eaten for the day',
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.blue[400],
        elevation: 3.0,
      ),
      bottomNavigationBar: BottomAppBar(
        color: kMainTheme,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.room_service,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => FoodHistory()),
//                  );
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.explore,
                  size: 30,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiscoverPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.white,
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.chevron_left,
                  color: kMainTheme,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.calendar_today,
                  color: kMainTheme,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  '${weekdays[_dateTime.weekday % 7]}, ${_dateTime.day} ${months[_dateTime.month - 1]}',
                  style: TextStyle(color: kMainTheme),
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.chevron_right,
                  color: kMainTheme,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            color: kDimPink,
            child: Text(
              'OVERVIEW',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 10, left: 50, right: 50),
            color: kDimPink,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '0',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Icon(
                      Icons.whatshot,
                      size: 30,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
              height: 165,
              width: 165,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'images/wheel.PNG',
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CircularNutritionIndicator(
                  color: Colors.green,
                  nutrition: 'FATS',
                ),
                CircularNutritionIndicator(
                  color: Colors.blue,
                  nutrition: 'PROTEINS',
                ),
                CircularNutritionIndicator(
                  color: Colors.red,
                  nutrition: 'CARBS',
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: kDimPink,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(75),
                bottomRight: Radius.circular(75),
              ),
            ),
          ),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              !experiencedUser
                  ? Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      margin: EdgeInsets.fromLTRB(40, 20, 40, 20),
                      child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Get Started'),
                              Icon(Icons.arrow_right)
                            ],
                          ),
                          onPressed: () {
                            setState(() {
                              experiencedUser = true;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MealLog(),
                                ));
                          }),
                    )
                  : SizedBox(),
            ],
          ),
        ],
      ),
    );
  }
}
