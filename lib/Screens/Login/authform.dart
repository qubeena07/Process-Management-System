//this form is for lettng user enter their login credentials
import 'package:flutter/material.dart';
import 'package:proces/Screens/Home/home.dart';
import 'package:proces/Screens/fade_animats.dart';
import 'package:proces/Screens/Login/forgotPassword.dart';
import '../Home/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class authform extends StatefulWidget {
  const authform({Key? key}) : super(key: key);

  @override
  _authformState createState() => _authformState();
}

class _authformState extends State<authform> {
  // var isLoading = false;
  final _auth = FirebaseAuth.instance;

  final _formState = GlobalKey<FormState>();
  late String? _userEmail;
  late String? _userPass;
//taking the login credetinals and validating if they are in correct format
//the function is asynchronous
  Future<void> _trySubmit() async {
    //validating if the data user input is correct
    final _isValid = _formState.currentState?.validate();
    //unfocusing the keyboard
    FocusScope.of(context).unfocus();
//if the data inserted by user is correct authenticatin them with firebase
    if (_isValid!) {
      _formState.currentState?.save();
      try {
        await _auth
            .signInWithEmailAndPassword(
                email: _userEmail!.trim(), password: _userPass!)
            .then((user) => Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => home()),
                (route) => false));
      } on FirebaseAuthException catch (err) {
        Fluttertoast.showToast(msg: err.code);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _isObscure = true;
    return Center(
      child: Card(
        // ignore: prefer_const_constructors
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            // ignore: prefer_const_constructors
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formState,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (value) {
                      //validating if input email is correct
                      if (value!.isEmpty || !value.contains('@')) {
                        return 'please enter a valid email address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: "email",
                        icon: Icon(Icons.verified_user)),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  TextFormField(
                    validator: (value) {
                      //validating if user password format is correct and is not empty
                      if (value!.isEmpty || value.length < 6) {
                        return 'Password must be atlease 6 characters long';
                      }
                      return null;
                    },
                    //keyboardType: TextInputType.visiblePassword,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Password',
                        hintText: "Password",
                        icon: const Icon(Icons.enhanced_encryption),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            })),
                    onSaved: (value) {
                      _userPass = value;
                    },
                  ),
                  const SizedBox(height: 12),
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
                          onTap: _trySubmit,
                          child: const Center(
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )),
                    //const SizedBox(
                    //  height: 30,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const forgotPassword()),
                        );
                      },
                      child: const Text(
                        "Forgot your password?",
                        style: TextStyle(
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
