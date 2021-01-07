import 'package:flutter/material.dart';

//import 'package:schoolah_mobile_app/mainScreens/splashscreen.dart';
import 'package:schoolah_mobile_app/studentScreens/tuitionfee.dart';

void main() => runApp(
  MaterialApp(
    title: 'Schoo-Lah',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.orange),
    home: TuitionFeeScreen(),
  ),
);