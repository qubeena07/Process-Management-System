//this is the main dart file foe the project
//this is the first file that gets executed
import 'package:flutter/material.dart';
import 'Screens/Home/home.dart';
import 'Screens/onboarding/onboarding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class App extends StatelessWidget {
  //here the firebase app gets initialized as a future value
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proces Management System',
      //themeMode: ThemeMode.system,
      //darkTheme: MyThemes.darkTheme,

      // theme: MyThemes.lightTheme,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: Colors.blue,
          buttonTheme: ButtonTheme.of(context).copyWith(
              buttonColor: Colors.blue,
              textTheme: ButtonTextTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ))),
      //this stream Builder checks if the application has data saved from previous sessions
      //if so the application rejoins the user who was logged in
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, userSnapshot) {
            final screenHeight = MediaQuery.of(context).size.height;
            if (userSnapshot.hasData) {
              return (const home());
            }
            //if the user has no logged in data from past
            //the first page opens to the user
            return (Onboarding(
              screenHeight: screenHeight,
            ));
          }),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}
