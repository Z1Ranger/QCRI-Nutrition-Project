import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:org/constants.dart';
import 'package:org/screens/food_log.dart';
import 'package:org/widgets/meal_widget.dart';

class MealLog extends StatefulWidget {
  final date;

  MealLog([this.date]);

  @override
  _MealLogState createState() => _MealLogState();
}

class _MealLogState extends State<MealLog> {
  TimeOfDay _timeOfDay = TimeOfDay.now();
  Meal selectedMeal;

  void setMeal() {
    if (5 < _timeOfDay.hour && _timeOfDay.hour < 11) {
      selectedMeal = Meal.breakfast;
    } else if (12 < _timeOfDay.hour && _timeOfDay.hour < 15) {
      selectedMeal = Meal.lunch;
    } else if (18 < _timeOfDay.hour && _timeOfDay.hour < 21) {
      selectedMeal = Meal.dinner;
    } else {
      selectedMeal = Meal.snack;
    }
  }

  String getMeal(meal) {
    if (meal == Meal.breakfast) {
      return 'breakfast';
    } else if (meal == Meal.lunch) {
      return 'lunch';
    } else if (meal == Meal.dinner) {
      return 'dinner';
    } else {
      return 'snack';
    }
  }

  @override
  void initState() {
    super.initState();
    setMeal();
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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 40.0),
            child: Text(
              'Select Meal',
              style: TextStyle(
                  color: kMainTheme, fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMeal = Meal.breakfast;
                  });
                },
                child: MealWidget(
                  color: selectedMeal == Meal.breakfast
                      ? Colors.grey[200]
                      : Colors.white,
                  meal: 'Breakfast',
                  image: 'images/breakfast-icon.png',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMeal = Meal.lunch;
                  });
                },
                child: MealWidget(
                  color: selectedMeal == Meal.lunch
                      ? Colors.grey[200]
                      : Colors.white,
                  meal: 'Lunch',
                  image: 'images/lunch-icon.png',
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMeal = Meal.dinner;
                  });
                },
                child: MealWidget(
                  color: selectedMeal == Meal.dinner
                      ? Colors.grey[200]
                      : Colors.white,
                  meal: 'Dinner',
                  image: 'images/dinner-icon.png',
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    selectedMeal = Meal.snack;
                  });
                },
                child: MealWidget(
                  color: selectedMeal == Meal.snack
                      ? Colors.grey[200]
                      : Colors.white,
                  meal: 'Snack',
                  image: 'images/snack-icon.png',
                ),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: kMainTheme,
            ),
            margin: EdgeInsets.symmetric(vertical: 20),
            child: FlatButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FoodLog(getMeal(selectedMeal), widget.date)),
              ),
              child: Text(
                'NEXT',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
