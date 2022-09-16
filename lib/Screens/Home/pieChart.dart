//this page displays the piechart at the home page for the user
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:proces/controller/create_new_project_controller.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

//creating a stateless widget
class ChartApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const _MyHomePage(),
    );
  }
}

//extending the stateful widget from the homepage
class _MyHomePage extends StatefulWidget {
  const _MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

//calling  the private class of stateful widget
class _MyHomePageState extends State<_MyHomePage> {
  //creating variables to store data of running processes
  static List<String> todo = [];
  static List<String> Ongoing = [];
  static List<String> Verified = [];
  static List<String> Completed = [];
  //this function is to call another function when this class gets called
  @override
  void initState() {
    list_todo();
    super.initState();
  }

//this is a asynchronous method to retrieve data of running process for piechart
  list_todo() async {
    final procescontroller = Get.put(CreateNewUser());
    int i = procescontroller.Process.length;
    todo = [];
    Ongoing = [];
    Verified = [];
    Completed = [];
//this for statement retrieves and groups the process with the stage they are in
    for (i; i > 0; i--) {
      var a = i - 1;
      if (procescontroller.Process[a].atstage == 'todo') {
        String b = (procescontroller.Process[a].name!);
        List<String> c = b.split(' ');
        todo = todo + c;
      }
      if (procescontroller.Process[a].atstage == 'On-going') {
        String b = (procescontroller.Process[a].name!);
        List<String> c = b.split(' ');
        Ongoing = Ongoing + c;
      }
      if (procescontroller.Process[a].atstage == 'Verified') {
        String b = (procescontroller.Process[a].name!);
        List<String> c = b.split(' ');
        Verified = Verified + c;
      }
      if (procescontroller.Process[a].atstage == 'Completed') {
        String b = (procescontroller.Process[a].name!);
        List<String> c = b.split(' ');
        Completed = Completed + c;
      }
    }
  }

  //to show the retrieved information in piechart
  //its saved in list
  late List<_SalesData> chartData = [
    _SalesData('Todo', todo.length),
    _SalesData('Ongoing', Ongoing.length),
    _SalesData('Verified', Verified.length),
    _SalesData('Completed', Completed.length),
  ];
  //returning a piechart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5), //color of shadow
          spreadRadius: 5, //spread radius
          blurRadius: 7,
        )
      ]),
      height: 500,

      width: 320,
      //the piechart is a SFCircular chart provided by Syncfunction inc
      child: SfCircularChart(
          title: ChartTitle(text: "On going Processess"),
          legend: Legend(isVisible: true),
          backgroundColor: const Color.fromARGB(255, 243, 243, 243),
          onDataLabelRender: (DataLabelRenderArgs args) {
            int value = int.parse(args.text);
            args.text = value.toStringAsFixed(0);
          },
          series: <CircularSeries<_SalesData, String>>[
            PieSeries<_SalesData, String>(
                selectionBehavior: SelectionBehavior(enable: true),
                explode: true,
                dataSource: chartData,
                xValueMapper: (_SalesData sales, _) => sales.year,
                yValueMapper: (_SalesData sales, _) => sales.sales,
                name: 'Sales',
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                ))
          ]),
      //child: PieChart(dataMap: dataMap),
    )));
  }
}

class _SalesData {
  _SalesData(this.year, this.sales);
  late String year;
  late int sales;
}
