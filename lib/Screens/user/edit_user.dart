//this page allows admin to delete any existing user
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:proces/Screens/user/user_profile.dart';
import 'package:proces/controller/create_new_project_controller.dart';
import 'package:proces/models/newprocess.dart';

class editUser extends StatefulWidget {
  const editUser({Key? key}) : super(key: key);

  @override
  _editUserState createState() => _editUserState();
}

class _editUserState extends State<editUser> {
  void initState() {
    list_todo();
    super.initState();
  }

  static List<String> process = [];
  //initializing controller
  final procescontroller = Get.put(getusers());
  //creating a asynchronous function to retrieve user data
  list_todo() async {
    int i = await procescontroller.Usr.length;
    print(i);
    if (process != null) {
      process = [];
    }
    for (i; i > 0; i--) {
      var a = i - 1;

      String b = (procescontroller.Usr[a].Fullname!);

      List<String> c = b.split(' ');
      process = process + c;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: ListView.builder(
          itemCount: process.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  showAlertDialog(context, index);
                },
                trailing: const Icon(Icons.delete),
                title: Text(process[index]),
              ),
            );
          }),
    );
  }

//Alert dialogbox to make sure the admin wants to delete tehe user
  void showAlertDialog(BuildContext context, index) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        //this function calls a model and sende the users name
        //which delets the user from firebase authentication and database
        create_new_process_class().delete(index);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => editUser()),
            (route) => true);
      },
    );
    Widget cancel = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => editUser()),
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
      content: const Text("Are you sure you want to delete this user?"),
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
}
