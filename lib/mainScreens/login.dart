import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPageScreen extends StatefulWidget 
{
  @override 
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State <LoginPageScreen>
{
  @override 
  Widget build(BuildContext context)
  {
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
                    height: 140.0,
                    child: Image.asset('assets/schoolah_logo.png'),
                  ),

                  SizedBox(height: 31.0),

                  Text(
                    'LOGIN',
                    style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)
                  ),

                  SizedBox(height: 20.0),

                  TextField(
                    obscureText: false,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Enter Username',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),

                  SizedBox(height: 15.0),

                  TextField(
                    obscureText: false,
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Enter Password',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),

                  SizedBox(height: 20.0),

                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {},
                    label: Text('       LOGIN       ', 
                      style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold)
                    ),
                  ),

                  SizedBox(height: 30.0),

                  Text(
                    'Forgot Password?',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
                  ),

                  SizedBox(height: 15.0),

                  Text(
                    'First Time User? Sign Up Now!',
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)
                  ),

                  SizedBox(height: 90.0),

                  Text(
                    'Terms and Conditions',
                    style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)
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