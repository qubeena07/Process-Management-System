// this function creates a model for firestore data to be saved in our running program
//importing packages
import 'package:cloud_firestore/cloud_firestore.dart';

//Creating model cass for firebase collection
class userdata {
  //initializing data
  final String? email;
  final String? fullName;
  final String? password;
//Assigning data with constructor
  const userdata({
    this.email,
    this.fullName,
    this.password,
  });
//Assigning variable data from firebase collection
  static userdata fromSnapshot(DocumentSnapshot snap) {
    userdata emaildata = userdata(
      email: snap['email'],
      fullName: snap['fullName'],
      password: snap['password'],
    );
    return emaildata;
  }
}
