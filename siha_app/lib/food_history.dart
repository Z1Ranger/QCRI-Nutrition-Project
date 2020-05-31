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
          return Container(
            margin: EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF773A87),
                    Color(0xFFC92B5F),
                    Colors.pinkAccent,
                  ]),
            ),
            child: Column(
              children: <Widget>[
                FlatButton(
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
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          uniqueTime[index],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          uniqueMealTime[index],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
