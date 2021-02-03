//import 'dart:js';

import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/mainScreens/signup.dart';
import 'package:schoolah_mobile_app/mainScreens/teachersignup.dart';
import 'package:schoolah_mobile_app/models/mock_users.dart';
import 'package:schoolah_mobile_app/models/mock_todos.dart';
import 'package:schoolah_mobile_app/studentScreens/bookstore.dart';
import 'package:schoolah_mobile_app/studentScreens/qrscan.dart';

import 'package:schoolah_mobile_app/studentScreens/studenthome.dart';
import 'package:schoolah_mobile_app/studentScreens/studentprofile.dart';
import 'package:schoolah_mobile_app/studentScreens/subjectlist.dart';
import 'package:schoolah_mobile_app/studentScreens/tasklist.dart';
import 'package:schoolah_mobile_app/studentScreens/tuitionfee.dart';
import 'package:schoolah_mobile_app/teacherScreens/addTask.dart';
import 'package:schoolah_mobile_app/teacherScreens/qrhistory.dart';
import 'package:schoolah_mobile_app/teacherScreens/qrsubjectlist.dart';
import 'package:schoolah_mobile_app/teacherScreens/teacherstudentlist.dart';
import 'package:schoolah_mobile_app/teacherScreens/teachersubjectlist.dart';
import 'package:schoolah_mobile_app/teacherScreens/tasklistTeacher.dart';
import 'package:schoolah_mobile_app/teacherScreens/teacherhome.dart';
import 'package:schoolah_mobile_app/teacherScreens/teacherprofile.dart';
import 'package:schoolah_mobile_app/teacherScreens/qrscanningzone.dart';

import 'constants.dart';
import 'login.dart';

Route<dynamic> createRoute(settings) {
  // final routeName = settings.name;
  // final data = settings.arguments;

  switch (settings.name) {
    case homeRoute:
    case studHome:
      return MaterialPageRoute(
        builder: (context) => StudentHomePageScreen(),
      );

    case studBook:
      return MaterialPageRoute(
        builder: (context) => BookstorePageScreen(),
      );

    case studFee:
      return MaterialPageRoute(
        builder: (context) => TuitionFeeScreen(),
      );

    case studProfile:
      return MaterialPageRoute(
        builder: (context) => StudentProfileScreen(),
      );

    case studTask:
      return MaterialPageRoute(
        builder: (context) => StudentTaskListScreen(mockData[0]),
      );

    case studSubject:
      return MaterialPageRoute(
        builder: (context) => StudentSubjectListScreen(mockData),
      );

    case teacherSubject:
      return MaterialPageRoute(
        builder: (context) => TeacherSubjectListScreen(mockData),
      );

    case teachTask:
      return MaterialPageRoute(
        builder: (context) => TaskListScreen(),
      );

    case teachProfile:
      return MaterialPageRoute(
        builder: (context) => TeacherProfileScreen(),
      );

    case teachStudentList:
      return MaterialPageRoute(
        builder: (context) => TeacherStudentListScreen(),
      );

    case teachHome:
      return MaterialPageRoute(
        builder: (context) => TeacherHomePageScreen(globalUserList[1]),
      );

    case signup:
      return MaterialPageRoute(
        builder: (context) => SignupPageScreen(),
      );

    case login:
      return MaterialPageRoute(
        builder: (context) => LoginPageScreen(),
      );

    case teacherSignup:
      return MaterialPageRoute(
        builder: (context) => TeacherSignupPageScreen(),
      );

    case teachAddTask:
      return MaterialPageRoute(
        builder: (context) => AddTaskScreen(),
      );

    case teachQR:
      return MaterialPageRoute(
        builder: (context) => DetailsScreen(),
      );

    case QRcode:
      return MaterialPageRoute(
        builder: (context) => ScanScreen(),
      );

    case teachScanZone:
      return MaterialPageRoute(
        builder: (context) => ScanZoneScreen(),
      );

    case QRStudentcode:
      return MaterialPageRoute(
        builder: (context) => QRScreen(),
      );
  }

  return null;
}
