//this pages allows user to create new user stories
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:proces/Screens/processess/pushData.dart';
import 'package:proces/Screens/user_stories/push.dart';
import 'package:proces/controller/create_new_project_controller.dart';

class storiesForm extends StatefulWidget {
  const storiesForm({Key? key}) : super(key: key);

  @override
  _storiesFormState createState() => _storiesFormState();
}

class _storiesFormState extends State<storiesForm> {
  String? proc;
  String? priority;
  void initState() {
    list_todo();
    super.initState();
  }

  static List<String> todo = [];
  final procescontroller = Get.put(CreateNewUser());
//this asynchronous function searches for the number of department and displays it for choosing
  list_todo() async {
    int i = await procescontroller.Process.length;
    if (todo != null) {
      todo = [];
    }
    for (i; i > 0; i--) {
      var a = i - 1;
      String b = (procescontroller.Process[a].name!);
      List<String> c = b.split(' ');
      todo = todo + c;
    }
  }

  final proName = [
    'Admission Process',
    'App developmet',
    'Presentation Process'
  ];
  String? value;
  final Upriority = [
    'Must do',
    'Should do',
    'Could do',
    'Dont do',
  ];
  String? value1;
  final descriptionController = TextEditingController();
  final informController = TextEditingController();
  final criteriaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User-Stories Form'),
      ),
      body: Form(
          child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: ListView(
          children: [
            const Text(
              "Process Name:",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black45,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: DropdownButton<String>(
                  hint: Text(
                    'Choose process name',
                  ),
                  value: value,
                  iconSize: 40,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black54,
                  ),
                  isExpanded: true,
                  items: todo.map(buildMenuItem).toList(),
                  onChanged: (value) {
                    setState(() {
                      this.value = value;
                      proc = value;
                    });
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            const Text(
              "User Story Priority:",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.black45,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: DropdownButton<String>(
                  hint: Text(
                    'Choose priority..',
                  ),
                  value: value1,
                  iconSize: 40,
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black54,
                  ),
                  isExpanded: true,
                  items: Upriority.map(buildMenuItem1).toList(),
                  onChanged: (value1) {
                    setState(() {
                      this.value1 = value1;
                      priority = value1;
                    });
                  }),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 80,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                autofocus: false,
                //obscureText: true,
                decoration: InputDecoration(
                  labelText: ' User Story: ',
                  labelStyle: TextStyle(fontSize: 20.0),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),

                controller: descriptionController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Write the description of user story';
                  }
                  return null;
                },
                maxLength: 200,
                maxLines: 5,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  labelText: 'Additional Information:',
                  labelStyle: TextStyle(fontSize: 20.0),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
                controller: informController,
                // validator: (value) {
                //   if (value == null || value.isEmpty) {
                //     return 'Please Enter Name of process';
                //   }
                //   return null;
                // },
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                autofocus: false,
                decoration: const InputDecoration(
                  labelText: 'Acceptance Criteria:',
                  labelStyle: TextStyle(fontSize: 20.0),
                  border: OutlineInputBorder(),
                  errorStyle: TextStyle(color: Colors.redAccent, fontSize: 15),
                ),
                controller: criteriaController,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      pushdata().senddata(
                          proc,
                          priority,
                          descriptionController.text,
                          informController.text,
                          criteriaController.text);
                    },
                    child: const Text(
                      'Create User Story',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String proName) => DropdownMenuItem(
      value: proName,
      child: Text(
        proName,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
      ));
  DropdownMenuItem<String> buildMenuItem1(String Upriority) => DropdownMenuItem(
      value: Upriority,
      child: Text(
        Upriority,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
      ));
}
