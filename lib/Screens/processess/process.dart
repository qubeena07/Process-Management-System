import 'package:flutter/material.dart';
import 'package:proces/Screens/Home/home.dart';
import 'package:proces/Screens/processess/process_form.dart';

import 'package:proces/Screens/processess/old_process.dart';
import 'package:proces/Screens/processess/running_process.dart';

class processes extends StatefulWidget {
  const processes({Key? key}) : super(key: key);

  @override
  _processesState createState() => _processesState();
}

class _processesState extends State<processes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Processes"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const processForm()));
              },
              fillColor: Colors.orange,
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.add),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("Create new process",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            RawMaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => oldProcess()));
              },
              fillColor: Colors.orange,
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.remove_red_eye_outlined),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("View old process",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
            SizedBox(
              height: 15,
            ),
            RawMaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => runningProcess()));
              },
              fillColor: Colors.orange,
              padding: EdgeInsets.all(10.0),
              shape: CircleBorder(),
              child: Column(
                // Replace with a Row for horizontal icon + text
                children: <Widget>[
                  Icon(Icons.slow_motion_video_outlined),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("View running process",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
