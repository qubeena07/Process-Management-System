//this page displays the list of user stories available
import 'package:flutter/material.dart';
import 'package:proces/Screens/Home/home.dart';
import 'package:proces/Screens/user_stories/edit_userStories.dart';
import 'package:proces/Screens/user_stories/userStories_Form.dart';

class userStories extends StatefulWidget {
  const userStories({Key? key}) : super(key: key);

  @override
  _userStoriesState createState() => _userStoriesState();
}

class _userStoriesState extends State<userStories> {
  final titles = [
    'marketing',
    'sales',
    'screen',
    'guitar',
  ];
  void showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => userStories()),
            (route) => true);
      },
    );
    Widget cancel = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => userStories()),
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
      content: const Text("Are you sure you want to delete this user story?"),
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
        title: Text("User Stories"),
      ),
      body: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => editUserStories()),
                  );
                },
                title: Text(titles[index]),
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
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => storiesForm()),
      //     );
      //   },
      //   child: new Icon(Icons.add),
     // ),
    );
  }
}
