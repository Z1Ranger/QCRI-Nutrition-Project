import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:org/screens/meal_log.dart';
import 'user_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:org/constants.dart';
import 'package:org/widgets/circular_nutritional_indicator.dart';
import 'discover.dart';

bool experiencedUser = false;
DateTime _dateTime = DateTime.now();

class FoodLoggingOverview extends StatefulWidget {
  @override
  _FoodLoggingOverviewState createState() => _FoodLoggingOverviewState();
}

class _FoodLoggingOverviewState extends State<FoodLoggingOverview> {
  int cals = 0;
  int carbs = 0;
  int fats = 0;
  int proteins = 0;

  bool _isLoading = true;

  bool checkToday(DateTime date) {
    if (date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day) {
      return true;
    } else {
      return false;
    }
  }

  getData() async {
    String date = _dateTime.year.toString() +
        '-' +
        _dateTime.month.toString() +
        '-' +
        _dateTime.day.toString();
    print(date);
    http.Response response = await http.get(
      Uri.encodeFull(
          'https://siha-staging.qcri.org/siha-api/v1/nutrients/$date/1'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiIsImlhdCI6MTU5MjkwODU3OSwiZXhwIjoxNTkzNTEzMzc5fQ.eyJpZCI6MSwidXNlcl90eXBlIjoiQXBpVXNlciJ9.DiLJdDrc1YR-qZix_qwSjb8cPsTB7eeujTQa69IgYmNkFcqnniy_kiH9eJtwEUZ6_QnEelCIjoOZkn6_vmH5lQ'
      },
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      print(data);
      carbs = data["total_carbs"];
      cals = data["total_cals"];
      fats = data["total_fats"];
      proteins = data["total_proteins"];
      setState(() {
        _isLoading = false;
      });
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
//    getData();
  }

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
                GestureDetector(
                  child: Icon(
                    Icons.chevron_left,
                    color: kMainTheme,
                  ),
                  onTap: () {
                    setState(() {
                      _dateTime = _dateTime.subtract(Duration(days: 1));
                      getData();
                    });
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDate: _dateTime,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    ).then(
                      (date) {
                        setState(
                          () {
                            if (date != null) {
                              _dateTime = date;
                              getData();
                            }
                          },
                        );
                      },
                    );
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.calendar_today,
                        color: kMainTheme,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      checkToday(_dateTime)
                          ? Text(
                              'Today',
                              style: TextStyle(color: kMainTheme),
                            )
                          : Text(
                              '${weekdays[_dateTime.weekday % 7]}, ${_dateTime.day} ${months[_dateTime.month - 1]}',
                              style: TextStyle(color: kMainTheme),
                            ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _dateTime = _dateTime.add(Duration(days: 1));
                      getData();
                    });
                  },
                  child: Icon(
                    Icons.chevron_right,
                    color: kMainTheme,
                  ),
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
                    child: _isLoading
                        ? Text(
                            "0",
                            style: TextStyle(fontSize: 30),
                          )
                        : Text(
                            cals.toString(),
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
                  text: _isLoading ? "0" : fats.toString(),
                ),
                CircularNutritionIndicator(
                  color: Colors.blue,
                  nutrition: 'PROTEINS',
                  text: _isLoading ? "0" : proteins.toString(),
                ),
                CircularNutritionIndicator(
                  color: Colors.red,
                  nutrition: 'CARBS',
                  text: _isLoading ? "0" : carbs.toString(),
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
