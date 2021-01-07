import 'package:flutter/material.dart';

import './mainScreens/splashscreen.dart';

void main() => runApp(
  MaterialApp(
    title: 'Schoo-Lah',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.orange),
    home: SchoolahSplashScreen(),
  ),
);