import 'package:flutter/material.dart';
import 'package:flutter/src/material/dropdown.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
//import 'package:proces/Screens/processess/nextStep.dart';
import 'package:proces/Screens/processess/pushData.dart';
import 'package:proces/controller/create_new_project_controller.dart';
import 'package:proces/models/newprocess.dart';
import 'package:intl/intl.dart';

class editSavedproc extends StatefulWidget {
  const editSavedproc({Key? key}) : super(key: key);

  @override
  _editSavedprocState createState() => _editSavedprocState();
}

class _editSavedprocState extends State<editSavedproc> {
  DateTime selectedDate = DateTime.now();

   final items = [
    'Marketing',
    "Accounts",
    "Social Meidia",
    "IT",
    "HR",
    "Sales",
    "Manufacture",
    "Research"
  ];
 
  final procescontroller = Get.put(getusers());

  String? value;

  bool checkBoxValue = false;
  bool checkNow = false;
  bool stepValue = false;

  final firstDate = DateTime(2010, 1);
  final lastDate = DateTime(2030, 12);

  final _formKey = GlobalKey<FormState>();

  var name = '';
  var processLeader = '';
  var description = '';
  //var deadline = '';
  var nextStep = '';
  var subproc = '';
  DateTime? hehee;

  final nameController = TextEditingController();
  final leaderController = TextEditingController();
  final descriptionController = TextEditingController();
  final timeController = TextEditingController();
  final stepController = TextEditingController();
  static List<String> todo = [];

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    nameController.dispose();
    leaderController.dispose();
    descriptionController.dispose();
    timeController.dispose();
    stepController.dispose();

    super.dispose();
  }

  void initState() {
    list_todo();
    super.initState();
  }

  list_todo() async {
    if (todo.length > procescontroller.Usr.length) {
      todo = [];
      todo.length = todo.length - procescontroller.Usr.length;
    }
    int i = await procescontroller.Usr.length;
    for (i; i > 0; i--) {
      var a = i - 1;
      String b = (procescontroller.Usr[a].department!);

      List<String> c = b.split(' ');

      todo = todo + c;
    }
    List hey = todo;
  }

  clearText() {
    nameController.clear();
    leaderController.clear();
    descriptionController.clear();
    timeController.clear();
    stepController.clear();
  }

  String? tine = "Choose deadline day";
  String? dept;
  String? deadline;
  //final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Saved Process"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: const InputDecoration(
                    labelText: 'Name: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter Name of process';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: DropdownButton<String>(
                  hint: const Text(
                    'Process leader',
                  ),
                  value: value,
                  iconSize: 40,
                  icon: const Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black54,
                  ),
                  isExpanded: true,
                  items: items.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      this.value = value;
                      dept = value;
                    });
                    //setState(() => this.value = value);
                  },
                ),
              ),
              Container(
                height: 80,
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  //obscureText: true,
                  decoration: const InputDecoration(
                    labelText: ' Description: ',
                    labelStyle: TextStyle(fontSize: 20.0),
                    border: OutlineInputBorder(),
                    errorStyle:
                        TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),

                  controller: descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Write the description of project';
                    }
                    return null;
                  },
                  maxLength: 200,
                  maxLines: 5,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        child: const Icon(Icons.calendar_today_rounded),
                        onTap: () async {
                          print(dept);
                          hehee = await _openDatePicker(context);
                          print("hey $hehee");
                          //context: context,
                          // initialDate: DateTime.now(),
                          // firstDate: DateTime(2021),
                          //lastDate: DateTime(2022));
                          setState(() {
                            //tine = hehee.toString();
                            tine = DateFormat('yyyy-MM-dd').format(hehee!);
                            deadline = hehee.toString();
                            //tine = " 2022-02-01";
                          });
                        }),
                    labelText: tine,
                    labelStyle: const TextStyle(fontSize: 20.0),
                    border: const OutlineInputBorder(),
                    errorStyle:
                        const TextStyle(color: Colors.redAccent, fontSize: 15),
                  ),
                  controller: timeController,
                  validator: (value) {
                    if (value == null) {
                      return 'Nothing has been selected';
                    } else {
                      value = selectedDate.toString();
                    }
                    //return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        value: stepValue,
                        onChanged: (value) {
                          //print(value);
                          setState(() {
                            stepValue = value!;
                           // nextStep;
                            //return editSheet1();
                          });
                        }),
                    const Text("Next Step",
                        style: TextStyle(
                            fontSize: 22.0, fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Checkbox(
                        value: checkNow,
                        onChanged: (value) {
                          print(value);
                          setState(() {
                            checkNow = value!;
                          });
                        }),
                    const Text("Start the process now",
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.normal)),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            name = nameController.text;
                            //processLeader = leaderController.text;
                            description = descriptionController.text;
                            // deadline = timeController.text;
                            nextStep = stepController.text;
                            var saveforfuture = checkBoxValue;
                            var run_now = checkNow;
                            print("vhvk");
                            pushData().senddata(name, dept, description, tine,
                                nextStep, saveforfuture, run_now);

                            clearText();
                          });
                        }
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.lightBlueAccent),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String items) => DropdownMenuItem(
      value: items,
      child: Text(
        items,
        style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
      ));

  _openDatePicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    print(date);
    if (date != null) {
      setState(() {
        selectedDate = date;
      });

      return date;
    }
  }
}