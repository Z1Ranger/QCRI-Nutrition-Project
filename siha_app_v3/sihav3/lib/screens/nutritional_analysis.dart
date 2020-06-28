import 'package:flutter/material.dart';
import 'package:org/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:org/screens/food_logging_overview.dart';

class NutritionAnalysisPage extends StatefulWidget {
  final foodEaten;
  final datetime;
  final meal;

  NutritionAnalysisPage([this.foodEaten, this.datetime, this.meal]);

  @override
  _NutritionAnalysisPageState createState() => _NutritionAnalysisPageState();
}

class _NutritionAnalysisPageState extends State<NutritionAnalysisPage> {
  bool isLoading = true;
  dynamic data;

  getData() async {
    http.Response response = await http.get(
      Uri.encodeFull(
          'https://siha-staging.qcri.org/siha-api/v1/food_to_nutrients/${widget.foodEaten}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiIsImlhdCI6MTU5MjkwODU3OSwiZXhwIjoxNTkzNTEzMzc5fQ.eyJpZCI6MSwidXNlcl90eXBlIjoiQXBpVXNlciJ9.DiLJdDrc1YR-qZix_qwSjb8cPsTB7eeujTQa69IgYmNkFcqnniy_kiH9eJtwEUZ6_QnEelCIjoOZkn6_vmH5lQ'
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);

      setState(() {
        isLoading = false;
      });
      return 'success - showing food';
    } else {
      print(response.statusCode);
    }
  }

  String formattedTime(time) {
    if (0 < time.hour && time.hour < 12) {
      return '${time.hour}:${time.minute} AM';
    } else {
      return '${time.hour % 12}:${time.minute} PM';
    }
  }

  setFoodTextData() async {
    print(widget.datetime);
    print(widget.foodEaten);
    print(widget.meal);
    String date = widget.datetime.year.toString() +
        '-' +
        widget.datetime.month.toString() +
        '-' +
        widget.datetime.day.toString();
    http.Response response = await http.post(
      Uri.encodeFull('https://siha-staging.qcri.org/siha-api/v1/food_logging'),
      body: jsonEncode({
        'datetime': date,
        'patient': 1,
        'food_text': widget.foodEaten,
        'meal': widget.meal
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiIsImlhdCI6MTU5MjkwODU3OSwiZXhwIjoxNTkzNTEzMzc5fQ.eyJpZCI6MSwidXNlcl90eXBlIjoiQXBpVXNlciJ9.DiLJdDrc1YR-qZix_qwSjb8cPsTB7eeujTQa69IgYmNkFcqnniy_kiH9eJtwEUZ6_QnEelCIjoOZkn6_vmH5lQ'
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.statusCode);
    }
  }

  setNutritionalData(foodId, food, cals, carbs, proteins, fats) async {
    http.Response response = await http.post(
      Uri.encodeFull('https://siha-staging.qcri.org/siha-api/v1/nutrients'),
      body: jsonEncode({
        'food_log_id': foodId,
        'food_item': {
          'cals': cals,
          'carbs': carbs,
          'proteins': proteins,
          'fats': fats
        }
      }),
      headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer eyJhbGciOiJIUzUxMiIsImlhdCI6MTU5MjkwODU3OSwiZXhwIjoxNTkzNTEzMzc5fQ.eyJpZCI6MSwidXNlcl90eXBlIjoiQXBpVXNlciJ9.DiLJdDrc1YR-qZix_qwSjb8cPsTB7eeujTQa69IgYmNkFcqnniy_kiH9eJtwEUZ6_QnEelCIjoOZkn6_vmH5lQ'
      },
    );
    if (response.statusCode == 200) {
      return 'success - sending food';
    } else {
      print(response.statusCode);
    }
  }

  setData() async {
    dynamic result = await setFoodTextData();
    print(result);
    print(data);
    print(result['id'] is int);
    for (int i = 0; i < data['foods'].length; i++) {
      await setNutritionalData(
          result['id'],
          data['foods'][i]['food'],
          data['foods'][i]['nutrients']['cals'],
          data['foods'][i]['nutrients']['carbs'],
          data['foods'][i]['nutrients']['proteins'],
          data['foods'][i]['nutrients']['fats']);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.calendar_today,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          '${weekdays[widget.datetime.weekday % 7]}, ${widget.datetime.day} ${months[widget.datetime.month - 1]} \'${widget.datetime.year.toString().substring(2)}',
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Icon(Icons.access_time),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          formattedTime(widget.datetime),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                  Container(
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'images/${widget.meal}-icon.png',
                          height: 25,
                          width: 25,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Center(child: Text(widget.meal, style: TextStyle()))
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: Text('Food Entry Results: '),
            ),
            !isLoading
                ? Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(8),
                      itemCount: data['foods'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.network(
                                data['foods'][index]['img'],
                                width: 50,
                                height: 50,
                              ),
                              Text(data['foods'][index]['food'].toString()),
                            ],
                          ),
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(
                              top: 10, bottom: 5, left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      },
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: CircularProgressIndicator(),
                  ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kMainTheme,
              ),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
              child: FlatButton(
                onPressed: () async {
                  await setData();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodLoggingOverview()),
                  );
                },
                child: Text(
                  'SUBMIT',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}

class InformationEntity extends StatelessWidget {
  final text;

  InformationEntity([this.text]);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.bold, color: kMainTheme),
    );
  }
}
