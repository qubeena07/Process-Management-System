import 'package:flutter/material.dart';
import 'package:proces/controller/create_new_project_controller.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class runningProcess extends StatefulWidget {
  const runningProcess({Key? key}) : super(key: key);
  @override
  _runningProcess createState() => _runningProcess();
}

class _runningProcess extends State<runningProcess> {
  void initState() {
    list_todo();
    super.initState();
  }

  static List<String> process = [];
  final procescontroller = Get.put(CreateNewUser());
  list_todo() async {
    int i = await procescontroller.Process.length;
    if (process != null) {
      process = [];
    }
    for (i; i > 0; i--) {
      var a = i - 1;

      String b = (procescontroller.Process[a].name!);
      List<String> c = b.split(' ');
      process = process + c;
    }
    print(process);
  }

  final titles = [
    'marketing',
    'sales',
    'screen',
    'guitar',
    'tv',
    'fan',
    'remote',
    'diary',
    'lamp',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Running Process"),
      ),
      body: ListView.builder(
          itemCount: process.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {},
                title: Text(process[index]),
              ),
            );
          }),
    );
  }
}
