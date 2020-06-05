import 'package:flutter/material.dart';
import 'package:org/constants.dart';
import 'package:http/http.dart' as http;
import 'package:org/keys.dart';
import 'dart:convert';

import 'package:org/screens/food_logging_overview.dart';

List foodPhotos;
List foodNames;

class NutritionAnalysisPage extends StatefulWidget {
  final foodEaten;

  NutritionAnalysisPage([this.foodEaten]);

  @override
  _NutritionAnalysisPageState createState() => _NutritionAnalysisPageState();
}

class _NutritionAnalysisPageState extends State<NutritionAnalysisPage> {
  bool isLoading = true;

  getData() async {
    foodPhotos = [];
    foodNames = [];
    http.Response response = await http.post(
      Uri.encodeFull('https://trackapi.nutritionix.com/v2/natural/nutrients'),
      headers: {
        'x-app-id': nutrition_app_id,
        'x-app-key': nutrition_app_key,
        'x-remote-user-id': '0'
      },
      body: {'query': '${widget.foodEaten}'},
    );
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);

      for (int i = 0; i < data['foods'].length; i++) {
        foodPhotos.add(data['foods'][i]['photo']['thumb']);
        foodNames.add(data['foods'][i]['food_name']);
      }
      setState(() {
        isLoading = false;
      });
      return 'success - showing food';
    } else {
      print(response.statusCode);
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                      itemCount: foodNames.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Row(
//                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.network(
                                foodPhotos[index],
                                width: 50,
                                height: 50,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(foodNames[index]),
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
                : SizedBox(),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: kMainTheme,
              ),
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 35),
              child: FlatButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FoodLoggingOverview()),
                ),
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
