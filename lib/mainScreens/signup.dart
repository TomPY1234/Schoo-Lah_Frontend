import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/services/user_data_service.dart';
import '../dependencies.dart';

class SignupPageScreen extends StatefulWidget {
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPageScreen> {
  String username;
  String password;
  String name;
  String phone;
  String email;
  String school;
  int year;
  String _value = 'student';
  final UserDataService userDataService = service();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(child: Image.asset('assets/schoolah_logo.png', width: 100.0, height: 100.0,)),
                  Padding(padding: EdgeInsets.only(bottom: 10)),
                  Text('SIGNUP AS:', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
                  
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
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                        if (_value == 'teacher')
                          Navigator.pushNamed(context, '/teacherSignup');
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
                    onChanged: (value) => year = int.parse(value),
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Enter Year',
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
                    onChanged: (value) => school = value,
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
                    backgroundColor: Theme.of(context).primaryColorLight,
                    heroTag: null,
                    onPressed: () {
                      userDataService.registerNew(
                          username: username,
                          password: password,
                          name: name,
                          year: year,
                          school: school,
                          email: email,
                          type: _value,
                          phone: phone);
                      Navigator.pushNamed(context, '/login');
                    },
                    label: Text('SIGN UP', style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
                  ),

                  SizedBox(height: 20.0),
                  TextButton(
                    child: Text( 'Already Sign Up? Login Now!', style: TextStyle(color: Colors.black)),
                    onPressed: () { Navigator.pushNamed(context, '/login'); }
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
