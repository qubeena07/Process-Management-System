//This is controller for retrieveing packages 

//importing packages

import 'package:proces/models/process_fetch.dart';
import 'package:proces/models/running_processess.dart';
import 'package:proces/models/users_fetch.dart';
import '../services/newprojectdb.dart';
import 'package:get/get.dart';

//creating controller class
class CreateNewUser extends GetxController {
  //Creating variable to store data received from firebase
  final Process = <process>[].obs;
//creating onInit function so it loads first when class is called to call database service and retrieve data
  void onInit() {
    Process.bindStream(FirestoreDB().statechecker());
    super.onInit();
  }

//this function calls database service and retrieves data
  proc() {
    Process.bindStream(FirestoreDB().getAllProcess());
  }
}

//creating controller class
class CreateNewUsers extends GetxController {
  //Creating variable to store data received from firebase
  final Process = <process>[].obs;
//creating onInit function so it loads first when class is called to call database service and retrieve data

  void onInit() {
    Process.bindStream(FirestoreDB().statecheckers());
    super.onInit();
  }

//this function calls database service and retrieves data
  proc() {
    Process.bindStream(FirestoreDB().getAllProcess());
  }
}

//creating controller class
class saved extends GetxController {
  //Creating variable to store data received from firebase
  final SProcess = <savedprocess>[].obs;
//creating onInit function so it loads first when class is called to call database service and retrieve data
  void onInit() {
    SProcess.bindStream(FirestoreDB().saveddata());
    super.onInit();
  }

//this function calls database service and retrieves data
  proc() {
    SProcess.bindStream(FirestoreDB().saveddata());
  }
}

//creating controller class
class getusers extends GetxController {
  //Creating variable to store data received from firebase
  final Usr = <usr>[].obs;
//creating onInit function so it loads first when class is called to call database service and retrieve data
  void onInit() {
    Usr.bindStream(FirestoreDB().users());
    super.onInit();
  }
}
