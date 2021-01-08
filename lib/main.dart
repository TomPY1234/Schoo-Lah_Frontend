import 'package:flutter/material.dart';

import './studentScreens/bookstore.dart';
import 'mainScreens/login.dart';

void main() => runApp(
      MaterialApp(
        title: 'Schoo-Lah',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.orange),
        home: LoginPageScreen(),
      ),
    );
