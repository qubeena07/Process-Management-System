//this page allows users to see their user profile and change their password
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:proces/Screens/Home/home.dart';
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
    email = "Enter your email address here";
    String name = "Enter your name here";
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 15, top: 20, right: 15),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            //displaying the user details
            children: [
              const SizedBox(height: 50),
              buildTextField("Name", name, false),
              buildTextField("Email", email, false),
              const SizedBox(height: 30),
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
                        padding: const EdgeInsets.symmetric(horizontal: 50),
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
            fillColor: const Color.fromARGB(255, 192, 225, 252),
            filled: true,
            contentPadding: const EdgeInsets.all(5),
            labelText: labelText,
            labelStyle: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 20, color: Colors.black),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
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
          MaterialPageRoute(builder: (context) => const home()),
          (route) => true);
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
            padding: const EdgeInsets.all(5),
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
                    MaterialPageRoute(
                        builder: (context) => const userProfile()),
                    (route) => true);
              },
              child: const Text("Cancel")),
        ],
      ),
    ),
  );
}
