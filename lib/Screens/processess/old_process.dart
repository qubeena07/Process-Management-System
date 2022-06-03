import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:proces/controller/create_new_project_controller.dart';

import 'editoldproc.dart';

class oldProcess extends StatefulWidget {
  const oldProcess({Key? key}) : super(key: key);
  @override
  _oldProcess createState() => _oldProcess();
}

class _oldProcess extends State<oldProcess> {
  void initState() {
    list_todo();
    super.initState();
  }

  static List<String> process = [];
  final procescontroller = Get.put(saved());
  list_todo() async {
    int i = await procescontroller.SProcess.length;
    var j = await procescontroller.proc();
    print(j);
    print(i);
    if (process != null) {
      process = [];
    }
    for (i; i > 0; i--) {
      var a = i - 1;
      String b = (procescontroller.SProcess[a].name!);
      List<String> c = b.split(' ');
      process = process + c;
    }
    print(process);
  }

  final titles = [
    'Admission',
    'marketing',
    'sales',
    'budget',
    'Profit',
    'Content',
    'random',
    'state',
    'early',
    'todo',
    'screen',
    'guitar',
    'tv',
    'fan',
    'remote',
    'diary',
    'lamp',
  ];

//    _onDeleteItemPressed(item) {
//   titles.removeAt(item);
//   setState(() {});
//  }

  void showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => oldProcess()),
            (route) => true);
      },
    );
    Widget cancel = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => oldProcess()),
            (route) => true);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text(
        "Delete User",
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: const Text("Are you sure you want to delete this saved process?"),
      actions: [
        okButton,
        cancel,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Saved Process"),
      ),
      body: ListView.builder(
          itemCount: process.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  print(index);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => editSavedproc()),
                      (route) => true);
                  //editSavedproc();
                },
                title: Text(process[index]),
                trailing: GestureDetector(
                  child: const Icon(
                    Icons.delete,
                    size: 30,
                  ),
                  onTap: () {
                    showAlertDialog(context);
                  },
                ),
              ),
            );
          }),
    );
  }
}
