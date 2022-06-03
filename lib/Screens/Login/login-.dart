//this package is for the login page which calls the login form for the user
import 'package:flutter/material.dart';
import 'package:proces/Screens/fade_animats.dart';
import '../Login/authform.dart';

class Login2 extends StatefulWidget {
  @override
  _Login2State createState() => _Login2State();
  bool _isLogin = true;
}

class _Login2State extends State<Login2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: ListView(
        children: [
          Container(
              child: Image.asset('assets/images/proceso_logo.png',
                  width: 300, height: 200)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FadeAnimation(
                    1.5,
                    const Text(
                      "Login",
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
                      child: const authform(),
                    )),
                const SizedBox(
                  height: 30,
                  // child: const authform(),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
