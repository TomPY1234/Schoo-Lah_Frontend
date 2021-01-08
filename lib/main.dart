import 'package:flutter/material.dart';

import './studentScreens/bookstore.dart';
import 'mainScreens/login.dart';
import 'mainScreens/router.dart';

void main() => runApp(
      MaterialApp(
        onGenerateRoute: createRoute,
        title: 'Schoo-Lah',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.orange),
        home: LoginPageScreen(),
      ),
    );
