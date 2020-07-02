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
import 'package:org/screens/food_log.dart';

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

  dynamic mealNutrients = {
    'breakfast': {'cals': 0},
    'lunch': {'cals': 0},
    'dinner': {'cals': 0},
    'snack': {'cals': 0}
  };

  dynamic foodInformation = {
    'breakfast': [],
    'lunch': [],
    'dinner': [],
    'snack': []
  };

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
          'https://siha-staging.qcri.org/siha-api/v1/nutrients/date/$date/patient/1'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiIsImlhdCI6MTU5MzU4ODI2MiwiZXhwIjoxNTk0MTkzMDYyfQ.eyJpZCI6MSwidXNlcl90eXBlIjoiQXBpVXNlciJ9.tJf3Bb-6St2o_mcljTTEKSnTigttaMfLL5g9xOdFHkWf_QPYTKPfSTKRREWOIvE1eU7m0JcEsCf1E9eNeeIzUw'
      },
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      print(data);
      cals = data["total_nutrients"]["cals"];
      carbs = data["total_nutrients"]["carbs"];
      proteins = data["total_nutrients"]["proteins"];
      fats = data["total_nutrients"]["fats"];
      setState(() {
        _isLoading = false;
      });
    } else {
      print(response.statusCode);
    }
  }

  getBreakfastData() async {
    String date = _dateTime.year.toString() +
        '-' +
        _dateTime.month.toString() +
        '-' +
        _dateTime.day.toString();
    http.Response responseBreakfast = await http.get(
      Uri.encodeFull(
          'https://siha-staging.qcri.org/siha-api/v1/nutrients/date/$date/patient/1/meal/breakfast'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiIsImlhdCI6MTU5MzU4ODI2MiwiZXhwIjoxNTk0MTkzMDYyfQ.eyJpZCI6MSwidXNlcl90eXBlIjoiQXBpVXNlciJ9.tJf3Bb-6St2o_mcljTTEKSnTigttaMfLL5g9xOdFHkWf_QPYTKPfSTKRREWOIvE1eU7m0JcEsCf1E9eNeeIzUw'
      },
    );
    if (responseBreakfast.statusCode == 200) {
      print(jsonDecode(responseBreakfast.body));
      setState(() {
        mealNutrients['breakfast']['cals'] =
            jsonDecode(responseBreakfast.body)['total_meal_nutrients']['cals'];
        foodInformation['breakfast'] =
            jsonDecode(responseBreakfast.body)['food_items'];
      });
    } else {
      print(responseBreakfast.statusCode);
    }
  }

  getLunchData() async {
    String date = _dateTime.year.toString() +
        '-' +
        _dateTime.month.toString() +
        '-' +
        _dateTime.day.toString();

    http.Response responseLunch = await http.get(
      Uri.encodeFull(
          'https://siha-staging.qcri.org/siha-api/v1/nutrients/date/$date/patient/1/meal/lunch'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiIsImlhdCI6MTU5MzU4ODI2MiwiZXhwIjoxNTk0MTkzMDYyfQ.eyJpZCI6MSwidXNlcl90eXBlIjoiQXBpVXNlciJ9.tJf3Bb-6St2o_mcljTTEKSnTigttaMfLL5g9xOdFHkWf_QPYTKPfSTKRREWOIvE1eU7m0JcEsCf1E9eNeeIzUw'
      },
    );

    if (responseLunch.statusCode == 200) {
      print(jsonDecode(responseLunch.body));
      setState(() {
        mealNutrients['lunch']['cals'] =
            jsonDecode(responseLunch.body)['total_meal_nutrients']['cals'];
        foodInformation['lunch'] = jsonDecode(responseLunch.body)['food_items'];
      });
    } else {
      print(responseLunch.statusCode);
    }
  }

  getDinnerData() async {
    String date = _dateTime.year.toString() +
        '-' +
        _dateTime.month.toString() +
        '-' +
        _dateTime.day.toString();

    http.Response responseDinner = await http.get(
      Uri.encodeFull(
          'https://siha-staging.qcri.org/siha-api/v1/nutrients/date/$date/patient/1/meal/dinner'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiIsImlhdCI6MTU5MzU4ODI2MiwiZXhwIjoxNTk0MTkzMDYyfQ.eyJpZCI6MSwidXNlcl90eXBlIjoiQXBpVXNlciJ9.tJf3Bb-6St2o_mcljTTEKSnTigttaMfLL5g9xOdFHkWf_QPYTKPfSTKRREWOIvE1eU7m0JcEsCf1E9eNeeIzUw'
      },
    );

    if (responseDinner.statusCode == 200) {
      print(jsonDecode(responseDinner.body));
      setState(() {
        mealNutrients['dinner']['cals'] =
            jsonDecode(responseDinner.body)['total_meal_nutrients']['cals'];
        foodInformation['dinner'] =
            jsonDecode(responseDinner.body)['food_items'];
      });
    } else {
      print(responseDinner.statusCode);
    }
  }

  getSnackData() async {
    String date = _dateTime.year.toString() +
        '-' +
        _dateTime.month.toString() +
        '-' +
        _dateTime.day.toString();

    http.Response responseSnack = await http.get(
      Uri.encodeFull(
          'https://siha-staging.qcri.org/siha-api/v1/nutrients/date/$date/patient/1/meal/snack'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiIsImlhdCI6MTU5MzU4ODI2MiwiZXhwIjoxNTk0MTkzMDYyfQ.eyJpZCI6MSwidXNlcl90eXBlIjoiQXBpVXNlciJ9.tJf3Bb-6St2o_mcljTTEKSnTigttaMfLL5g9xOdFHkWf_QPYTKPfSTKRREWOIvE1eU7m0JcEsCf1E9eNeeIzUw'
      },
    );

    if (responseSnack.statusCode == 200) {
      print(jsonDecode(responseSnack.body));
      setState(() {
        mealNutrients['snack']['cals'] =
            jsonDecode(responseSnack.body)['total_meal_nutrients']['cals'];
        foodInformation['snack'] = jsonDecode(responseSnack.body)['food_items'];
      });
    } else {
      print(responseSnack.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    getBreakfastData();
    getLunchData();
    getSnackData();
    getDinnerData();
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
                      getBreakfastData();
                      getLunchData();
                      getSnackData();
                      getDinnerData();
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
                              getBreakfastData();
                              getLunchData();
                              getSnackData();
                              getDinnerData();
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
                              '${weekdays[_dateTime.weekday % 7]}, ${_dateTime.day} ${months[_dateTime.month - 1]} \'${_dateTime.year.toString().substring(2)}',
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
                      getBreakfastData();
                      getLunchData();
                      getSnackData();
                      getDinnerData();
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
                  image: 'images/cal2.png',
                  color: kMainTheme,
                  value: cals.toString(),
                  description: "Calories",
                ),
              ),
              Expanded(
                child: NutritionCard(
                  image: 'images/rice-bowl2.png',
                  color: kMainTheme,
                  value: carbs.toString(),
                  description: "Carbs",
                ),
              ),
              Expanded(
                child: NutritionCard(
                  image: 'images/protein2.png',
                  color: kMainTheme,
                  value: proteins.toString(),
                  description: "Proteins",
                ),
              ),
              Expanded(
                child: NutritionCard(
                  image: 'images/burger2.png',
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
                  data: foodInformation['breakfast'],
                  amount: mealNutrients['breakfast']['cals'].toString(),
                  navigate: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodLog('breakfast', _dateTime)),
                  ),
                ),
                MealCard(
                  meal: 'Lunch',
                  data: foodInformation['lunch'],
                  amount: mealNutrients['lunch']['cals'].toString(),
                  navigate: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodLog('lunch', _dateTime)),
                  ),
                ),
                MealCard(
                  meal: 'Dinner',
                  data: foodInformation['dinner'],
                  amount: mealNutrients['dinner']['cals'].toString(),
                  navigate: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodLog('dinner', _dateTime)),
                  ),
                ),
                MealCard(
                  meal: 'Snack',
                  data: foodInformation['snack'],
                  amount: mealNutrients['snack']['cals'].toString(),
                  navigate: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodLog('snack', _dateTime)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
