import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/models/data.dart';
import 'package:schoolah_mobile_app/studentScreens/bookstore.dart';

import 'package:schoolah_mobile_app/studentScreens/studenthome.dart';
import 'package:schoolah_mobile_app/studentScreens/studentprofile.dart';
import 'package:schoolah_mobile_app/studentScreens/subjectlist.dart';
import 'package:schoolah_mobile_app/studentScreens/tasklist.dart';
import 'package:schoolah_mobile_app/studentScreens/tuitionfee.dart';

import 'constants.dart';

Route<dynamic> createRoute(settings) {
  // final routeName = settings.name;
  // final data = settings.arguments;

  switch (settings.name) {
    case homeRoute:
    case studHome:
      return MaterialPageRoute(
        builder: (context) => StudentHomePageScreen(globalUserList[0]),
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
        builder: (context) => StudentTaskListScreen(),
      );

    case studSubject:
      return MaterialPageRoute(
        builder: (context) => StudentSubjectListScreen(),
      );
  }

  return null;
}
