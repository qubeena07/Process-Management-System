import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:proces/controller/create_new_project_controller.dart';
import 'package:proces/models/newprocess.dart';

class pushData {
  String? processName;
  String? processLeader;
  String? description;
  String? Deadline;
  String? nextStep;
  var saveforfuture;
  var runNow;
  String? processL;

  static List<String> todo = [];
  final procescontroller = Get.put(getusers());
  var least = 0;
  list_todo(processsL) async {}

  String? email = FirebaseAuth.instance.currentUser!.email;
  void senddata(String? processName, String? processLeader, String? description,
      String? Deadline, String? nextStep, var saveforfuture, var runNow) {
    list_todo(processLeader);
    int i = procescontroller.Usr.length;
    int least = 0;
    for (i; i > 0; i--) {
      var a = i - 1;

      print(procescontroller.Usr[a].department);
      if (procescontroller.Usr[a].department == processLeader) {
        if (procescontroller.Usr[a].tasks!.length >
            procescontroller.Usr[least].tasks!.length) {
          least = a;
        }
      }
    }
    processL = procescontroller.Usr[least].Fullname;
    if (runNow == true) {
      create_new_process_class().create_new_process(processName, processL,
          description, Deadline, nextStep, email, "todo");
    }
    if (saveforfuture == true) {
      create_new_process_class().create_new_process_save(processName,
          processLeader, description, Deadline, nextStep, email, "todo");
    }
  }
}
