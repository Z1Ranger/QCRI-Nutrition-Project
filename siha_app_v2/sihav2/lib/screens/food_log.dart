import 'package:flutter/material.dart';
import 'package:org/constants.dart';
import 'package:org/screens/nutritional_analysis.dart';

class FoodLog extends StatefulWidget {
  @override
  _FoodLogState createState() => _FoodLogState();
}

class _FoodLogState extends State<FoodLog> {
  DateTime _dateTime = DateTime.now();
  String foodEaten;

  bool checkToday(DateTime date) {
    if (date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day) {
      return true;
    } else {
      return false;
    }
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
//          Container(
//            color: Colors.white,
//            height: 50,
//          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    'WHAT DID YOU EAT?',
                    style: TextStyle(
                        color: kMainTheme,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        child: TextField(
                          onChanged: (value) {
                            foodEaten = value;
                          },
                          decoration: InputDecoration(
                            fillColor: kDimText,
                            filled: true,
                            border: OutlineInputBorder(),
                            hintText: 'Enter Food Consumed Here',
                          ),
                          autofocus: false,
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
                              foodEaten, _dateTime.toString())),
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
