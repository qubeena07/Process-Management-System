//this is the database service for the project
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:proces/models/process_fetch.dart';
import 'package:proces/models/running_processess.dart';
import 'package:proces/models/users_fetch.dart';

class FirestoreDB {
  //initializing firebase
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//this function returns all the data from the database
  Stream<List<process>> getAllProcess() {
    //returning data to the funchtion
    return _firebaseFirestore
        .collection('Running Processess')
        .where('deadline', isEqualTo: "todo")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => process.fromSnapshot(doc)).toList();
    });
  }

//this function returns all the data from the database
  Stream<List<process>> statechecker() {
    //returning data to the funchtion
    return _firebaseFirestore
        .collection('Running Processess')
        //.where('state', isEqualTo: task)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => process.fromSnapshot(doc)).toList();
    });
  }

  //this function returns spectfic data from the database
  Stream<List<process>> statecheckerss(task) {
    //returning data to the funchtion
    return _firebaseFirestore
        .collection('Running Processess')
        .where('state', isEqualTo: task)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => process.fromSnapshot(doc)).toList();
    });
  }

  //this function returns all the data from the database
  Stream<List<process>> statecheckers() {
    //returning data to the funchtion
    return _firebaseFirestore
        .collection('Saved Processess')
        //.where('state', isEqualTo: task)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => process.fromSnapshot(doc)).toList();
    });
  }

//this function returns all the data from the database
  Stream<List<savedprocess>> saveddata() {
    //returning data to the funchtion
    return _firebaseFirestore
        .collection("Saved Processess")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => savedprocess.fromSnapshot(doc))
          .toList();
    });
  }

//this function returns all the data from the database
  Stream<List<usr>> users() {
    //returning data to the funchtion
    return _firebaseFirestore
        .collection('users')
        //.where('state', isEqualTo: task)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => usr.fromSnapshot(doc)).toList();
    });
  }
}
