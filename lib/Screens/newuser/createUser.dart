//this page creates new user
import 'package:flutter/material.dart';
import 'package:proces/Screens/Home/home.dart';
import 'package:proces/Screens/Login/login-.dart';
import 'package:proces/Screens/fade_animats.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proces/models/newprocess.dart';

class createUser extends StatefulWidget {
  const createUser({Key? key}) : super(key: key);

  @override
  _createUserState createState() => _createUserState();
}

class _createUserState extends State<createUser> {
  final txtEmail = TextEditingController();
  final names = TextEditingController();
  final dept = TextEditingController();

  final txtPassword = TextEditingController();
  bool _isObscure = true;
  String? usertype;

//defining the type the new user created is
  final position = ['Admin', 'Department Head', 'Employee'];
  String? value;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              height: 75,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    height: 75,
                    width: width - 300,
                    //defining the image / gogo for the page with Fade animation
                    child: FadeAnimation(
                        1.3,
                        Container(
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/proceso_logo.png'),
                                  fit: BoxFit.fill)),
                        )),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeAnimation(
                      1.5,
                      const Text(
                        "Create New User",
                        style: TextStyle(
                            color: Color.fromRGBO(49, 39, 79, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                      1.7,
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromRGBO(196, 135, 198, .3),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              )
                            ]),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]!))),
                              child: TextFormField(
                                controller: txtEmail,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Email",
                                    icon: Icon(Icons.verified_user)),
                                //defining validator for the email
                                validator: (text) =>
                                    text!.isEmpty ? 'Email is required' : '',
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: TextFormField(
                                controller: txtPassword,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: _isObscure,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    icon: const Icon(Icons.enhanced_encryption),
                                    suffixIcon: IconButton(
                                        //defing the eye button for the page
                                        icon: Icon(_isObscure
                                            ? Icons.visibility
                                            : Icons.visibility_off),
                                        onPressed: () {
                                          setState(() {
                                            _isObscure = !_isObscure;
                                          });
                                        })),
                                //defining validator for the password
                                validator: (text) =>
                                    text!.isEmpty ? 'Password is required' : '',
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]!))),
                              child: TextFormField(
                                controller: names,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Name",
                                    icon: Icon(Icons.person)),
                                //defining validator for the name

                                validator: (text) => text!.isEmpty
                                    ? 'Full Name is required'
                                    : '',
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey[200]!))),
                              child: TextFormField(
                                controller: dept,
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Department",
                                    icon: Icon(Icons.cases_outlined)),
                                validator: (text) => text!.isEmpty
                                    ? 'Full Name is required'
                                    : '',
                              ),
                            ),
                            const Text(
                              "User Type:",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                fontSize: 15.50,
                                color: Colors.black45,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 5.0),
                              child: DropdownButton<String>(
                                hint: const Text(
                                  'Choose user type',
                                ),
                                value: value,
                                iconSize: 40,
                                icon: const Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.black54,
                                ),
                                isExpanded: true,
                                items: position.map(buildMenuItem1).toList(),
                                onChanged: (value) => setState(() {
                                  this.value = value;
                                  usertype = value;
                                }),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(
                    height: 30,
                  ),
                  FadeAnimation(
                    1.9,
                    Container(
                        height: 50,
                        margin: const EdgeInsets.symmetric(horizontal: 60),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromRGBO(49, 39, 79, 1),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            create_new_process_class().create_newuser(
                                txtEmail.text, names.text, dept.text, usertype);
                            //checking if the user data passes through validator
                            _trySubmit();
                            //is the input data passes through validator dialogbox return
                            showAlertDialog(context);
                          },
                          child: const Center(
                            child: Text(
                              "Create",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

//defining dropdown menu
  DropdownMenuItem<String> buildMenuItem(String department) => DropdownMenuItem(
      value: department,
      child: Text(
        department,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
      ));

  DropdownMenuItem<String> buildMenuItem1(String position) => DropdownMenuItem(
      value: position,
      child: Text(
        position,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
      ));

  final _auth = FirebaseAuth.instance;
  var name = "tkeeep";

  Future<void> _trySubmit() async {
    FocusScope.of(context).unfocus();
    var errorMessage;
    //adding users with the provided details
    try {
      //this sends data to the firebase and creates new user with the email and passowrd
      await _auth
          .createUserWithEmailAndPassword(
              email: txtEmail.text, password: txtPassword.text)
          .then((value) => {})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage!);
    }
  }
}

void showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => home()), (route) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(
      "User Created",
      style: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    content: const Text("New user is created."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
