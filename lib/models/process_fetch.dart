// this function creates a model for firestore data to be saved in our running program
//imporying packages
import 'package:cloud_firestore/cloud_firestore.dart';

//Creating model cass for firebase collection
class process {
  final String? Email;
  final String? name;
  final String? atstage;
  final String? Deadline;
  final String? description;
  final String? nextStep;
  final String? processLeader;
  final String? id;
//Assigning data with constructor
  const process({
    this.Email,
    this.name,
    this.atstage,
    this.Deadline,
    this.description,
    this.nextStep,
    this.processLeader,
    this.id,
  });
//Assigning data with constructor
  static process fromSnapshot(DocumentSnapshot snap) {
    process Process = process(
        id: snap['id'],
        Email: snap['E-mail'],
        description: snap['description'],
        name: snap['Name'],
        processLeader: snap['processLeader'],
        nextStep: snap['nextStep'],
        Deadline: snap['deadline'],
        atstage: snap['at-stage']);
    return Process;
  }
}
