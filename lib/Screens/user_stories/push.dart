//this page sends the data to be sent to the firestore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:proces/models/newprocess.dart';

//this function writes new user storied to the firestore 
class pushdata {
  String? processName;
  String? priority;
  String? userStory;
  String? Addinal_info;
  String? accep;
  void senddata(
    //receiving data from the user
    String? processName, String? priority, String? userStory,
      String? Addinal_info, String? accep) {
        //this calls a function from models which writes data to the firestore
        //this sends user stories data to be saved in firestore
    create_new_process_class()
        .user_stories(processName, priority, userStory, Addinal_info, accep);

  }
}
