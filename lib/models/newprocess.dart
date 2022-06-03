//importing packages
//this file pushes data into firestore collection
import 'package:intl/intl.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

//class for the functions
class create_new_process_class {
  String? processName;
  String? processLeader;
  var description;
  var Deadline;
  var nextStep;
  var CreatorEmail;
  var at_stage;
  var newStage;
//this function receives data and pushes them into firebase collection
  create_new_process(processName, processLeader, description, Deadline,
      nextStep, CreatorEmail, at_stage) {
    //initializing firebase instance with a collection
    var Document =
        FirebaseFirestore.instance.collection("Running Processess").doc();
    //writing the retrieved files into the firebase collection
    Document.set({
      "id": Document.id,
      "Name": processName,
      "processLeader": processLeader,
      "description": description,
      "deadline": Deadline,
      "nextStep": nextStep,
      "E-mail": CreatorEmail,
      "at-stage": at_stage,
    });
  }

//this function receives data and pushes them into firebase collection
  create_new_process_save(processName, processLeader, description, Deadline,
      nextStep, CreatorEmail, at_stage) {
    //initializing firebase instance with a collection
    var Document =
        FirebaseFirestore.instance.collection("Saved Processess").doc();
    //writing the retrieved files into the firebase collection
    Document.set({
      "id": Document.id,
      "Name": processName,
      "processLeader": processLeader,
      "description": description,
      "deadline": Deadline,
      "nextStep": nextStep,
      "E-mail": CreatorEmail,
      "at-stage": at_stage,
    });
  }

//this function receives document id and deletes it from firebase datastore
  delete_process(item) {
    //initializing firebase instance with a collection
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Running Processess").doc(item);
    //deleting the retrieved id from the firebase collection
    documentReference.delete();
  }

//this function receives document id and updates its content in firestore
  update_data(atStage, item) {
    //initializing firebase instance with a collection
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Running Processess").doc(item);
    if (atStage == "todo") {
      newStage = "On-going";
    }
    if (atStage == "On-going") {
      newStage = "Verified";
    }
    if (atStage == "Verified") {
      newStage = "Completed";
    }
    //Updating the retrieved id from the firebase collection
    Map<String, Object?> studentsDetails = {
      "at-stage": newStage,
    };
    documentReference.update(studentsDetails);
  }

  //this function receives document id and updates its content in firestore
  call_function(atStage, item) {
    //initializing firebase instance with a collection
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Running Processess").doc(item);
    if (atStage == "todo") {
      newStage = "On-going";
    }
    if (atStage == "On-going") {
      newStage = "Verified";
    }
    if (atStage == "Verified") {
      newStage = "Completed";
    }
    //Updating the retrieved id from the firebase collection
    Map<String, Object?> studentsDetails = {
      "at-stage": newStage,
    };
    documentReference.update(studentsDetails);
  }

//this function receives document id and updates its content in firestore
  back(atStage, item) {
    //initializing firebase instance with a collection
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection("Running Processess").doc(item);
    if (atStage == "On-going") {
      newStage = "todo";
    }
    if (atStage == "Verified") {
      newStage = "On-going";
    }
    if (atStage == "Completed") {
      newStage = "Verified";
    }
    //Updating the retrieved id from the firebase collection
    Map<String, Object?> studentsDetails = {
      "at-stage": newStage,
    };
    documentReference.update(studentsDetails);
  }

  user_stories(String? processName, String? priority, String? userStory,
      String? Addinal_info, String? accep) {
    var doc = FirebaseFirestore.instance.collection("User Stories").doc();
    doc.set({
      "id": doc.id,
      "Name": processName,
      "processLeader": priority,
      "description": userStory,
      "deadline": Addinal_info,
      "nextStep": accep,
    });
  }

//this function receives data and pushes them into firebase collection
  create_newuser(
      String? email, String? Fullname, String? department, String? ustype) {
    //initializing firebase instance with a collection
    String tasks = '0';
    var doc = FirebaseFirestore.instance.collection("users").doc();
    //writing the retrieved files into the firebase collection
    doc.set({
      "id": doc.id,
      "email": email,
      "Name": Fullname,
      "department": department,
      "userType": ustype,
      "tasks": tasks,
    });
  }

//this function deletes data from firebase
  delete(String? ustype) {
    //initializing firebase instance with a collection
    String tasks = '0';
    var doc = FirebaseFirestore.instance.collection("users").doc();
    //writing the retrieved files into the firebase collection
    doc.delete();
  }
}
