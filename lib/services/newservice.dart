//this is the database service for the project

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:proces/models/process_fetch.dart';

class FIrestoreDB {
  //initializing firebase
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  Stream<List<process>> processGetter() {
    //returning data to the funchtion
    return _firebaseFirestore
        .collection('Running Processess')
        //.where("Status", isEqualTo:data)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => process.fromSnapshot(doc)).toList();
    });
  }
}
