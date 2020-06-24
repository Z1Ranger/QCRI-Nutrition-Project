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
  TimeOfDay _timeOfDay = TimeOfDay.now();

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
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Datetime: ',
                          style: TextStyle(
                            fontSize: 18,
                            color: kMainTheme,
                          ),
                        ),
                        Text(
                          DateTime(
                            widget.date.year,
                            widget.date.month,
                            widget.date.day,
                            _timeOfDay.hour,
                            _timeOfDay.minute,
                          ).toString().split('.')[0],
                          style:
                              TextStyle(fontSize: 15, color: Color(0xff404040)),
                        ),
                      ],
                    ),
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
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.access_time),
                        SizedBox(
                          height: 5,
                        ),
                        Center(child: Text('Change Time', style: TextStyle()))
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            margin: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                              labelText: 'Log Food',
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
