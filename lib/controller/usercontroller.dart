//This is controller for retrieveing packages

import '../models/edituser.dart';
import '../services/userdb.dart';
import 'package:get/get.dart';

//creating controller class
class EmailController extends GetxController {
  //Creating variable to store data received from firebase
  final usersdata = <userdata>[].obs;
//creating onInit function so it loads first when class is called to call database service and retrieve data
  @override
  void onInit() {
    usersdata.bindStream(FirestoreDB().getAllEmails());
    super.onInit();
  }
}
