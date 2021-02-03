import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/services/user_service_rest.dart';
import 'package:schoolah_mobile_app/teacherScreens/teacherhome.dart';
import '../studentScreens/studenthome.dart';
import '../models/user.dart';

class LoginPageScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageScreen> {
  String username;
  String password;
  final dataService = UserServiceRest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 140.0,
                child: Image.asset('assets/schoolah_logo.png'),
              ),
              SizedBox(height: 31.0),
              Text('LOGIN',
                  style:
                      TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 20.0),
              TextField(
                obscureText: false,
                onChanged: (value) => username = value,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: 'Enter Username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 15.0),
              TextField(
                obscureText: true,
                onChanged: (value) => password = value,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: 'Enter Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0)),
                ),
              ),
              SizedBox(height: 20.0),
              FloatingActionButton.extended(
                backgroundColor: Theme.of(context).primaryColorLight,
                heroTag: null,
                onPressed: () async {
                  final User success =
                      await dataService.login(username, password);
                  if (success == null) {
                    showAlertDialog(context);
                  } else if (success.type == 'teacher') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return TeacherHomePageScreen(success); //teacherhome
                    }));
                  } else if (success.type == 'student') {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return StudentHomePageScreen();
                    }));
                  }
                },
                label: Text('       LOGIN       ',
                    style:
                        TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 30.0),
              Text('Forgot Password?',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 60.0),
              Text('Terms and Conditions',
                  style:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
              TextButton(
                  child: Text(
                    'First Time User? Sign Up Now!',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signup');
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enter a valid username and password.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Retry'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPageScreen();
                }));
              },
            ),
          ],
        );
      },
    );
  }
}
