import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:org/constants.dart';
import 'package:org/screens/food_log.dart';
import 'package:org/widgets/meal_widget.dart';

class MealLog extends StatefulWidget {
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
              'SELECT MEAL',
              style: TextStyle(
                  color: kMainTheme, fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: selectedMeal == Meal.breakfast
                      ? kDimPink
                      : Colors.white10,
                ),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      selectedMeal = Meal.breakfast;
                    });
                  },
                  child: MealWidget(
                    meal: 'BREAKFAST',
                    image: 'images/breakfast.png',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: selectedMeal == Meal.lunch ? kDimPink : Colors.white10,
                ),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      selectedMeal = Meal.lunch;
                    });
                  },
                  child: MealWidget(
                    meal: 'LUNCH',
                    image: 'images/lunch.png',
                  ),
                ),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color:
                      selectedMeal == Meal.dinner ? kDimPink : Colors.white10,
                ),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      selectedMeal = Meal.dinner;
                    });
                  },
                  child: MealWidget(
                    meal: 'DINNER',
                    image: 'images/dinner.png',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: selectedMeal == Meal.snack ? kDimPink : Colors.white10,
                ),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      selectedMeal = Meal.snack;
                    });
                  },
                  child: MealWidget(
                    meal: 'SNACK',
                    image: 'images/snack.png',
                  ),
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
                    builder: (context) => FoodLog(getMeal(selectedMeal))),
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
