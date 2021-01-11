import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/mainScreens/login.dart';
import 'package:schoolah_mobile_app/teacherScreens/teacherhome.dart';
import '../teacherScreens/teacherprofile.dart';
import '../studentScreens/studenthome.dart';
import '../models/user.dart';
import '../models/data.dart' as data;

class SignupPageScreen extends StatefulWidget {
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPageScreen> {
  String username;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange[500],
                Colors.orange[50],
                Colors.orange[300],
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    child: Image.asset('assets/schoolah_logo.png', scale: 15),
                  ),
                  SizedBox(height: 31.0),
                  Text('SIGNUP AS:',
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold)),

                  SizedBox(height: 20.0),
                  TextField(
                    obscureText: false,
                    onChanged: (value) => username = value,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Enter Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),

                  SizedBox(height: 20.0),
                  TextField(
                    obscureText: false,
                    onChanged: (value) => username = value,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Enter Age',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),

                  SizedBox(height: 20.0),
                  TextField(
                    obscureText: false,
                    onChanged: (value) => username = value,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Enter Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),

                  SizedBox(height: 20.0),
                  TextField(
                    obscureText: false,
                    onChanged: (value) => username = value,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Enter E-mail',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),

                  SizedBox(height: 20.0),
                  TextField(
                    obscureText: false,
                    onChanged: (value) => username = value,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Enter School',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),

                  SizedBox(height: 20.0),
                  TextField(
                    obscureText: false,
                    onChanged: (value) => username = value,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Enter Username',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextField(
                    obscureText: true,
                    onChanged: (value) => password = value,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    label: Text('       SIGN UP       ',
                        style: TextStyle(
                            fontSize: 19.0, fontWeight: FontWeight.bold)),
                  ),
                  //      style: TextStyle(
                  //     fontSize: 20.0, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Future login(String us, String pw, List<User> users) async {
  //   for (var u in users) {
  //     if (us == u.username && pw == u.password) {
  //       return Future.value(u);
  //     }
  //   }
  //   return null;
  // }

  // Future<void> showAlertDialog(BuildContext context) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('Login Failed'),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text('Please enter a valid username and password.'),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('Retry'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //               Navigator.push(context, MaterialPageRoute(builder: (context) {
  //                 return SignupPageScreen();
  //               }));
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
