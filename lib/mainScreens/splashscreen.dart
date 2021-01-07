import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SchoolahSplashScreen extends StatefulWidget 
{
  @override 
  _SchoolahSplashState createState() => _SchoolahSplashState();
}

class _SchoolahSplashState extends State <SchoolahSplashScreen>
{
  @override 
  Widget build(BuildContext context)
  {
    return SplashScreen(
      seconds: 7,
      navigateAfterSeconds: {},
      image: Image.asset('assets/schoolah_logo.png'),
      gradientBackground: LinearGradient(
        colors: [
          Colors.orange[200],
          Colors.orange[50],
          Colors.orange[200],
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      backgroundColor: Colors.white,
      photoSize: 150.0,
      loaderColor: Colors.black,
    );
  }
}