//this page displays the running processess to employees
// the processess state can be changed from on to another from this page

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:proces/Screens/Home/home.dart';
import 'package:proces/controller/create_new_project_controller.dart';
import 'package:proces/models/newprocess.dart';
import 'todoList.dart';

DateTime selectedDate = DateTime.now();
//date picker for date
final firstDate = DateTime(2010, 1);
final lastDate = DateTime(2030, 12);

class listOne extends StatefulWidget {
  const listOne({Key? key}) : super(key: key);

  @override
  _listOneState createState() => _listOneState();
}

class _listOneState extends State<listOne> {
  static List<String> taskname = [
    'presentation',
    'coding',
    'survey',
    'development',
    'talks'
  ];
  void initState() {
    list_todo();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

//initializing list for stages
  static List<String> todo = [];
  static List<String> Ongoing = [];
  static List<String> Verified = [];
  static List<String> Completed = [];

  final procescontroller = Get.put(CreateNewUser());
  // this asynchronous function retrieved the stages of running function
  list_todo() async {
    int i = await procescontroller.Process.length;
    print(i);
    if (todo != null) {
      todo = [];
    }
    if (Ongoing != null) {
      Ongoing = [];
    }
    if (Verified != null) {
      Verified = [];
    }
    if (Completed != null) {
      Completed = [];
    }
    for (i; i > 0; i--) {
      var a = i - 1;
      if (procescontroller.Process[a].atstage == 'todo') {
        String b = (procescontroller.Process[a].name!);
        List<String> c = b.split(' ');
        todo = todo + c;
      }
      if (procescontroller.Process[a].atstage == 'On-going') {
        //print(procescontroller.Process[a].atstage);
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

  static List<String> desc = [
    'presentation is assigned to you',
    'coding is still to do',
    'survey questions need to filled',
    'survey questions need to filled',
    'survey questions need to filled',
  ];

  List todos() {
    int i = procescontroller.Process.length;
    for (i; i > 0; i--) {
      var a = i - 1;
      if (procescontroller.Process[a].atstage == 'todo') {
        String b = (procescontroller.Process[a].name!);
        List<String> c = b.split(' ');
        todo = todo + c;
      }
    }

    return todo;
  }

  final List<todoList> todoData = List.generate(
      todo.length, (index) => todoList('${todo[index]}', '${desc[index]}'));
  final List<todoList> ongo = List.generate(Ongoing.length,
      (index) => todoList('${Ongoing[index]}', '${desc[index]}'));
  final List<todoList> veri = List.generate(Verified.length,
      (index) => todoList('${Verified[index]}', '${desc[index]}'));
  final List<todoList> compli = List.generate(Completed.length,
      (index) => todoList('${Completed[index]}', '${desc[index]}'));

  dynamic _a = 'Todo';
  @override
  //this build widget lists down the prcessess with their heading
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("tasks"),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 20.0),
        height: 700.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    "$_a",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: todoData.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(todoData[index].name),
                              onTap: () {
                                //opens a alertbox where user can see its details and change its state
                                Get.to(
                                    editSheet(
                                        context, todoData[index].name, "todo"),
                                    arguments: procescontroller.Process[index]);
                              },
                            ),
                          );
                        }),
                  ),
                ],
              ),
              width: 200.0,
              color: Colors.blue,
            ),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "On-going",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: ongo.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(ongo[index].name),
                              onTap: () {
                                Get.to(
                                    //opens a alertbox where user can see its details and change its state
                                    editSheet(
                                        context, ongo[index].name, "On-going"),
                                    arguments: procescontroller.Process[index]);
                              },
                            ),
                          );
                        }),
                  ),
                ],
              ),
              width: 200.0,
              color: Colors.blue,
            ),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Verified",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: veri.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(veri[index].name),
                              onTap: () {
                                Get.to(
                                    //opens a alertbox where user can see its details and change its state
                                    editSheet(
                                        context, veri[index].name, "Verified"),
                                    arguments: procescontroller.Process[index]);
                                //editSheet(context, veri[index].name);
                              },
                            ),
                          );
                        }),
                  ),
                ],
              ),
              width: 200.0,
              color: Colors.blue,
            ),
            Container(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  const Text(
                    "Completed",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: compli.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(compli[index].name),
                              onTap: () {
                                Get.to(
                                    //opens a alertbox where user can see its details and change its state
                                    editSheet(context, compli[index].name,
                                        "Completed"),
                                    arguments: procescontroller.Process[index]);
                                //editSheet(context, compli[index].name);
                              },
                            ),
                          );
                        }),
                  ),
                ],
              ),
              width: 200.0,
              color: Colors.blue,
            ),
          ],
        ),
      ),
      //),
    );
  }
}

//alertbox for the user to change process state
Widget editSheet(BuildContext context, name, stage) {
  //displaying the data ofprocess in dialog box
  final procescontroller = Get.put(CreateNewUser());
  String? newStage;
  int i = procescontroller.Process.length;

  int? inti;
  for (i; i > 0; i--) {
    var a = i - 1;
    if (name == procescontroller.Process[a].name) {
      inti = a;
      print(procescontroller.Process[a].name);
    }
  }
  String? item = procescontroller.Process[inti!].id;

  return AlertDialog(
    title: const Text(
      "Process Details",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    content: Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(5),
            child: TextFormField(
              initialValue: procescontroller.Process[inti].name.toString(),
              decoration: const InputDecoration(
                label: Text('Name:'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: TextFormField(
              initialValue:
                  procescontroller.Process[inti].processLeader.toString(),
              decoration: InputDecoration(
                label: Text('Process Leader:'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: TextFormField(
              initialValue:
                  procescontroller.Process[inti].description.toString(),
              decoration: InputDecoration(
                label: Text('Description:'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: TextFormField(
              initialValue: procescontroller.Process[inti].Deadline.toString(),
              decoration: InputDecoration(
                prefixIcon: GestureDetector(
                  child: Icon(Icons.calendar_today_rounded),
                  onTap: () => _openDatePicker(context),
                ),
                // hintText: 'Enter process name',
                label: Text('Deadline Time:'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: TextFormField(
              initialValue: procescontroller.Process[inti].nextStep.toString(),
              decoration: const InputDecoration(
                // hintText: 'Enter process name',
                label: Text('Next Step:'),
              ),
            ),
          ),
          const Spacer(),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                //determines what to do to a process when presed to move front
                if (stage != "Completed") {
                  create_new_process_class().update_data(stage, item);
                }
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => home()));
//determines who to do when a process is completed
                if (stage == "Completed") {
                  create_new_process_class().call_function(stage, item);
                }
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => home()));
              },
              child: const Text("Move front")),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                //determines what to do to a process when presed to move back
                if (stage != "todo") {
                  create_new_process_class().back(stage, item);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => home()));
                }
              },
              child: const Text("Move back")),
        ],
      ),
    ),
  );
}

_openDatePicker(BuildContext context) async {
  final DateTime? date = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );
}
