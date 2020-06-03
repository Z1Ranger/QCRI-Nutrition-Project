import 'package:flutter/material.dart';
import 'package:org/constants.dart';

class NutritionAnalysisPage extends StatefulWidget {
  @override
  _NutritionAnalysisPageState createState() => _NutritionAnalysisPageState();
}

class _NutritionAnalysisPageState extends State<NutritionAnalysisPage> {
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
    );
  }
}
