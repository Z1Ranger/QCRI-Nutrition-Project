import 'package:flutter/material.dart';
import 'package:org/constants.dart';
import 'package:org/screens/nutritional_analysis.dart';

class FoodLog extends StatefulWidget {
  @override
  _FoodLogState createState() => _FoodLogState();
}

class _FoodLogState extends State<FoodLog> {
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
                  '${weekdays[DateTime.now().weekday % 7]}, ${DateTime.now().day} ${months[DateTime.now().month - 1]}',
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
                          builder: (context) => NutritionAnalysisPage()),
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
