//this file is the home page for the application and all the authorization takes place here
//Al the navigation is done through this page
//importing packages
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:proces/Screens/Home/homepage.dart';
import 'package:proces/Screens/Login/login-.dart';
import 'package:proces/Screens/calendar/calendar.dart';
import 'package:proces/Screens/newuser/createUser.dart';
import 'package:proces/Screens/tasks/listOne.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:proces/Screens/user/edit_user.dart';
import 'package:proces/controller/create_new_project_controller.dart';
import 'package:proces/Screens/processess/process.dart';
import 'package:proces/Screens/user/user_profile.dart';
import '../Home/pieChart.dart';
import 'package:proces/Screens/user_stories/userStories.dart';

//Creating Stateful widget for the class
class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  _homeState createState() => _homeState();
}

//initializing coltroller
final procescontroller = Get.put(getusers());

//private class for the stateful widget
class _homeState extends State<home> {
  //defining the current index
  int _currentIndex = 1;
  void onInit() {
    //calling this function to check authorization state
    //  list_todo();
    super.initState();
  }

  final padding = EdgeInsets.symmetric(horizontal: 20);
  //gettig the screens for bottomnavigation ready
  final screens = [
    const Calendar(),
    const homepage(),
    const userProfile(),
  ];
  //initializing firebase auth
  FirebaseAuth auth = FirebaseAuth.instance;
//keeing the signout function
  Future<void> signOut() async {
    await auth.signOut();
  }
//for checing authorization
  // list_todo() {
  //   userrole = procescontroller.Usr[1].ustype;

  //   print(userrole);
  //   if (userrole == "Employee") {
  //     if (mounted) {
  //       setState(() {
  //         authourization = false;
  //       });
  //     }
  //   } else if (userrole == "Department Head") {
  //     if (mounted) {
  //       setState(() {
  //         authourization = true;
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Material(
        color: Colors.blueGrey,
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 48),
            buildMenuItem(
              text: "Home",
              icon: Icons.home,
              onClicked: () => selectedItem(context, 0),
            ),
            //defining visibility for user
            // // Visibility(
            // //   visible: authourization,
            // child:
            SizedBox(height: 20), //),
            buildMenuItem(
              text: "Processes",
              icon: Icons.article_rounded,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: "Tasks",
              icon: Icons.task,
              onClicked: () => selectedItem(context, 3),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: "User-stories",
              icon: Icons.amp_stories_rounded,
              onClicked: () => selectedItem(context, 4),
            ),
            //defining visibility for user

            // Visibility(
            //   visible: authourization,
            // child:
            const SizedBox(height: 20),
            buildMenuItem(
              text: "Create New User",
              icon: Icons.verified_user_sharp,
              onClicked: () => selectedItem(context, 5),
            ),
            // Visibility(
            //   visible: authourization,
            // child:
            const SizedBox(height: 20),
            buildMenuItem(
              text: "View User",
              icon: Icons.edit_attributes_sharp,
              onClicked: () => selectedItem(context, 6),
            ),
            const SizedBox(height: 20),
            buildMenuItem(
              text: "Logout",
              icon: Icons.logout,
              onClicked: () => selectedItem(context, 7),
            ),
          ],
        ),
      )),
      //Appbar defining for the page
      appBar: AppBar(
        title: Text("PROCESO"),
        backgroundColor: Colors.blueAccent,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      //screens[_currentIndex],
      //Defining buttom navigation for user
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.lightBlue,
          selectedItemColor: Colors.white,
          iconSize: 22,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: "Calendar",
                backgroundColor: Colors.black12),
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
                backgroundColor: Colors.black12),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_circle_rounded),
                label: "User-Profile",
                backgroundColor: Colors.black12),
          ],
          //Using the buttomnavigation to naviagte t
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          }),
    );
  }

  Widget buildMenuItem({
    VoidCallback? onClicked,
    required String text,
    required IconData icon, // Function() onClicked,
  }) {
    final color = Colors.white;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: TextStyle(color: color)),
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => home(),
        ));
        break;
//navigating through the side bar
      case 1:
        Navigator.of(context).push(MaterialPageRoute(
          //builder: (context) => processes(),
          builder: (context) => processes(),
        ));
        break;

      case 3:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => listOne(),
        ));
        break;
      case 4:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => userStories(),
        ));
        break;
      case 5:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const createUser(),
        ));
        break;
      case 6:
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const editUser(),
        ));
        break;
      case 7:
        signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => Login2()),
            (route) => false);
    }
  }
}
