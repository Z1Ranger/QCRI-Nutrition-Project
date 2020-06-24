import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:org/screens/meal_log.dart';
import 'package:org/widgets/meal_widget.dart';
import 'user_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:org/constants.dart';
import 'package:org/widgets/nutrition_card.dart';
import 'package:org/widgets/circular_nutritional_indicator.dart';
import 'discover.dart';
import 'package:org/widgets/meal_card.dart';

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
          MaterialPageRoute(builder: (context) => MealLog(_dateTime)),
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
                  Icons.favorite_border,
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
                  Icons.local_library,
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
          Row(
            children: <Widget>[
              Expanded(
                child: NutritionCard(
                  image: 'images/cal.png',
                  color: kMainTheme,
                  value: cals.toString(),
                  description: "Calories",
                ),
              ),
              Expanded(
                child: NutritionCard(
                  image: 'images/rice-bowl.png',
                  color: kMainTheme,
                  value: carbs.toString(),
                  description: "Carbs",
                ),
              ),
              Expanded(
                child: NutritionCard(
                  image: 'images/bean.png',
                  color: kMainTheme,
                  value: proteins.toString(),
                  description: "Proteins",
                ),
              ),
              Expanded(
                child: NutritionCard(
                  image: 'images/burger.png',
                  color: kMainTheme,
                  value: fats.toString(),
                  description: "Fats",
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: <Widget>[
                MealCard(
                  meal: 'Breakfast',
                  amount: '0',
                ),
                MealCard(
                  meal: 'Lunch',
                  amount: '0',
                ),
                MealCard(
                  meal: 'Dinner',
                  amount: '0',
                ),
                MealCard(
                  meal: 'Snack',
                  amount: '0',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
