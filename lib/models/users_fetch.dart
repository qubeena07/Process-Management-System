// this function creates a model for firestore data to be saved in our running program
//importing packages
import 'package:cloud_firestore/cloud_firestore.dart';

//Creating model cass for firebase collection
class usr {
  final String? email;
  final String? Fullname;
  final String? department;
  final String? ustype;
  final String? tasks;
//Assigning data with constructor
  const usr({
    this.email,
    this.Fullname,
    this.department,
    this.ustype,
    this.tasks,
  });
  //Assigning variable data from firebase collection
  static usr fromSnapshot(DocumentSnapshot snap) {
    usr Usr = usr(
        email: snap['email'],
        Fullname: snap['Name'],
        department: snap['department'],
        ustype: snap['userType'],
        tasks: snap['tasks']);
    return Usr;
  }
}
