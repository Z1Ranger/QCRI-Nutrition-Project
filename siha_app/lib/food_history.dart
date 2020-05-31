import 'package:flutter/material.dart';
import 'package:org/constants.dart';
import 'main.dart';

class FoodHistory extends StatefulWidget {
  @override
  _FoodHistoryState createState() => _FoodHistoryState();
}

class _FoodHistoryState extends State<FoodHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMainThemeColor,
        title: FlatButton(
          child: Image.asset(
            kAppBarLogo,
            height: 100,
            width: 100,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: uniqueEntries.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: FlatButton(
              color: Colors.blue[300],
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FoodInput(
                      uniqueEntries[index],
                    ),
                  ),
                );
              },
              child: Center(
                child: Text(
                  uniqueEntries[index],
                ),
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Text(uniqueTime[index]),
                    color: Colors.blue[200],
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Text(uniqueMealTime[index]),
                    color: Colors.blue[100],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
