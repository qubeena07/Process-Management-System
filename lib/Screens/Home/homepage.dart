//this page calls the piechart for the homepage
import 'package:flutter/material.dart';
import 'package:proces/Screens/Home/home.dart';
import '../Home/pieChart.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  //returing the piechart for homepage
  Widget build(BuildContext context) {
    return ChartApp();
  }
}
