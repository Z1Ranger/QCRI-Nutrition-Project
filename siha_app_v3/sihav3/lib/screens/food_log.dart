import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:org/constants.dart';
import 'package:org/screens/nutritional_analysis.dart';

class FoodLog extends StatefulWidget {
  final meal;
  final date;

  FoodLog([this.meal, this.date]);

  @override
  _FoodLogState createState() => _FoodLogState();
}

class _FoodLogState extends State<FoodLog> {
  String foodEaten;
  DateTime _date;
  TimeOfDay _timeOfDay = TimeOfDay.now();

  setDate() {
    _date = widget.date;
  }

  bool checkToday(DateTime date) {
    if (date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day) {
      return true;
    } else {
      return false;
    }
  }

  String formattedTime(TimeOfDay time) {
    if (0 < time.hour && time.hour < 12) {
      return '${time.hour}:${time.minute} AM';
    } else {
      return '${time.hour % 12}:${time.minute} PM';
    }
  }

  @override
  void initState() {
    super.initState();
    setDate();
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
        children: <Widget>[
          GestureDetector(
            onTap: () {
              showDatePicker(
                context: context,
                initialDate: _date,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              ).then(
                (date) {
                  setState(
                    () {
                      if (date != null) {
                        _date = date;
                      }
                    },
                  );
                },
              );
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.calendar_today,
                    color: kMainTheme,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  checkToday(_date)
                      ? Text(
                          'Today',
                          style: TextStyle(color: kMainTheme),
                        )
                      : Text(
                          '${weekdays[_date.weekday % 7]}, ${_date.day} ${months[_date.month - 1]} \'${_date.year.toString().substring(2)}',
                          style: TextStyle(
                            color: kMainTheme,
                            fontSize: 16,
                          ),
                        ),
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          ),
          GestureDetector(
            onTap: () {
              showTimePicker(
                context: context,
                initialTime: TimeOfDay(minute: 0, hour: 0),
              ).then(
                (time) {
                  setState(
                    () {
                      if (time != null) {
                        _timeOfDay = time;
                      }
                    },
                  );
                },
              );
            },
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.access_time),
                  SizedBox(
                    width: 10,
                  ),
                  Center(
                      child: Text(formattedTime(_timeOfDay),
                          style: TextStyle(
                            fontSize: 16,
                          )))
                ],
              ),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'What did you eat for ${widget.meal}?',
                    style: TextStyle(
                        color: kMainTheme,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 5),
                        child: TextField(
                          onChanged: (value) {
                            foodEaten = value;
                          },
                          style: TextStyle(
                            color: Color(0xff404040),
                          ),
                          decoration: const InputDecoration(
                              icon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                              hintText: 'Enter food consumed',
                              hintStyle: TextStyle(color: kMainTheme),
                              labelText: 'Enter Food',
                              labelStyle: TextStyle(color: kMainTheme)),
                        ),
                      ),
                    ),
                    FlatButton(
                      onPressed: () {},
                      child: Icon(Icons.mic),
                    ),
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
                          builder: (context) => NutritionAnalysisPage(
                              foodEaten,
                              DateTime(
                                widget.date.year,
                                widget.date.month,
                                widget.date.day,
                                _timeOfDay.hour,
                                _timeOfDay.minute,
                              ),
                              widget.meal)),
                    ),
                    child: Text(
                      'NEXT',
                      style: TextStyle(color: Colors.white),
                    ),
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
