//this page allows users to see their user profile and change their password
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:proces/Screens/Home/home.dart';
import 'package:proces/controller/create_new_project_controller.dart';
import 'package:proces/models/newprocess.dart';
import 'package:firebase_auth/firebase_auth.dart';

class userProfile extends StatefulWidget {
  const userProfile({Key? key}) : super(key: key);

  @override
  _userProfileState createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  bool isObscurePassword = true;

  @override
  Widget build(BuildContext context) {
    //retrieveing the current users email
    String? email; //''= FirebaseAuth.instance.currentUser!.email;
    email = "aayushbasnet012@gmail.com";
    String name = "Aayush";
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            //displaying the user details
            children: [
              SizedBox(height: 50),
              buildTextField("Name", name, false),
              buildTextField("Email", email, false),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(editSheet1(context));
                    },
                    child: const Text("Change password",
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 1,
                          color: Colors.white,
                        )),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

//this widget builds textFields when called upon
  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: TextField(
        obscureText: isPasswordTextField ? isObscurePassword : false,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(bottom: 5),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            )),
      ),
    );
  }
}

//this is a alert dialog box for to change password
void showAlertDialog(BuildContext context) {
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => home()), (route) => true);
    },
  );
  AlertDialog alert = AlertDialog(
    title: const Text(
      "Password Updated",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    content: const Text("Password Updated successfully"),
    actions: [
      okButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget editSheet1(BuildContext context) {
  bool isObscurePassword = true;
  String? email = FirebaseAuth.instance.currentUser!.email;
  String? u = email;
  bool isPasswordTextField = true;
  return AlertDialog(
    title: const Text(
      "Change Password",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    content: Container(
      child: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(5),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                label: Text('Old Password:'),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: TextField(
              obscureText: isPasswordTextField ? isObscurePassword : true,
              decoration: const InputDecoration(
                label: Text('New Password:'),
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              onPressed: () {
                showAlertDialog(context);
                //this class changes the password of the user in firebase
                // Future passwordChanger(
                //     //the class takes current password and new passowrd
                //     String currentPassword,
                //     String newPassword) async {
                //   final user = FirebaseAuth.instance.currentUser;
                //   //this retrieves the current email and password
                //   final cred = EmailAuthProvider.credential(
                //       email: user!.email!, password: currentPassword);

                //   await user
                //       //this authenticates the passowrd of the user again
                //       .reauthenticateWithCredential(cred)
                //       .then((value) async {
                //     await
                //         //this updates the new password
                //         user.updatePassword(newPassword);
                //     //this alert dialog box confirms the passw change
                //     return showAlertDialog(context);
                //   }).catchError((err) {
                //     return err;
                //   });
                //}
              },
              child: const Text("Update")),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => userProfile()),
                    (route) => true);
              },
              child: const Text("Cancel")),
        ],
      ),
    ),
  );
}
