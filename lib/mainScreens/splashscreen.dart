import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'login.dart';

class SchoolahSplashScreen extends StatefulWidget {
  @override
  _SchoolahSplashState createState() => _SchoolahSplashState();
}

class _SchoolahSplashState extends State<SchoolahSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 7,
      navigateAfterSeconds: LoginPageScreen(),
      image: Image.asset('assets/schoolah_logo.png'),
      backgroundColor: Theme.of(context).accentColor,
      photoSize: 150.0,
      loaderColor: Colors.black,
    );
  }
}
