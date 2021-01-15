import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/models/user.dart';
import '../models/mock_users.dart' as data;

class TeacherSignupPageScreen extends StatefulWidget {
  @override
  TeacherSignupPageState createState() => TeacherSignupPageState();
}

class TeacherSignupPageState extends State<TeacherSignupPageScreen> {
  String username;
  String password;
  String name;
  String phone;
  String email;
  String _value = 'teacher';
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
                  DropdownButton(
                      value: _value,
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      iconSize: 30,
                      items: [
                        DropdownMenuItem(
                            child: Text('Student'), value: 'student'),
                        DropdownMenuItem(
                            child: Text('Teacher'), value: 'teacher')
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                        if (_value == 'student')
                          Navigator.pushNamed(context, '/signup');
                      }),
                  SizedBox(height: 20.0),
                  TextField(
                    obscureText: false,
                    onChanged: (value) => name = value,
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
                    onChanged: (value) => phone = value,
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
                    onChanged: (value) => email = value,
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
                      final newuser = User(
                          username: username,
                          password: password,
                          name: name,
                          year: 0,
                          email: email,
                          type: _value,
                          phone: phone);
                      data.globalUserList.add(newuser);
                      //print(data.globalUserList.length);
                      Navigator.pushNamed(context, '/login');
                    },
                    label: Text('       SIGN UP       ',
                        style: TextStyle(
                            fontSize: 19.0, fontWeight: FontWeight.bold)),
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
