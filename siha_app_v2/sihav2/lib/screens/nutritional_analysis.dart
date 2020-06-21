import 'package:flutter/material.dart';
import 'package:org/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:org/screens/food_logging_overview.dart';

class NutritionAnalysisPage extends StatefulWidget {
  final foodEaten;
  final date;

  NutritionAnalysisPage([this.foodEaten, this.date]);

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
            'Bearer eyJhbGciOiJIUzUxMiIsImlhdCI6MTU5MjI4OTEzMCwiZXhwIjoxNTkyODkzOTMwfQ.eyJpZCI6MSwidXNlcl90eXBlIjoiQXBpVXNlciJ9.Lisr-OYxbr8o71sIHPZkRyD_yRTqV5it0j0uy2KOJ6Pl-74Wircy0k56ciundmFjff9YVQQMiUgxvdC8N0OLow'
      },
    );
    if (response.statusCode == 200) {
      data = jsonDecode(response.body);
      print(data);

      setState(() {
        isLoading = false;
      });
      return 'success - showing food';
    } else {
      print(response.statusCode);
    }
  }

  setData() async {
    http.Response response = await http.post(
      Uri.encodeFull('http://z1ranger.pythonanywhere.com/food'),
      body: jsonEncode({
        'date': '${widget.date}',
        'tot_cals': '${data['tot_cals']}',
        'tot_fats': '${data['tot_fats']}',
        'tot_proteins': '${data['tot_proteins']}',
        'tot_cabs': '${data['tot_cabs']}'
      }),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return 'success - sending food';
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
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
//          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: kDimPink,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InformationEntity('IMG'),
                  InformationEntity('FOOD'),
                  InformationEntity('QTY'),
                  InformationEntity('CALORIES'),
                  InformationEntity('CARBS'),
                  InformationEntity('PROTEINS'),
                  InformationEntity('FATS'),
                ],
              ),
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
                              Text(data['foods'][index]['qty'].toString()),
                              Text(data['foods'][index]['nutrients']['cals']
                                  .toString()),
                              Text(data['foods'][index]['nutrients']['carbs']
                                  .toString()),
                              Text(data['foods'][index]['nutrients']['proteins']
                                  .toString()),
                              Text(data['foods'][index]['nutrients']['fats']
                                  .toString()),
                            ],
                          ),
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
                onPressed: () {
                  setData();
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
          fontSize: 9, fontWeight: FontWeight.bold, color: kMainTheme),
    );
  }
}
