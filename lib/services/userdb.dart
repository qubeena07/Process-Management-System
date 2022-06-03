//this is the database service for the project
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/edituser.dart';

class FirestoreDB {
  //initializing firebase
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
//this function returns all the data from the database
  Stream<List<userdata>> getAllEmails() {
    //returning data to the funchtion
    return _firebaseFirestore
        .collection('userdata')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => userdata.fromSnapshot(doc)).toList();
    });
  }
}
