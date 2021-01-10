import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './studentScreens/bookstore.dart';
import 'mainScreens/login.dart';
import 'mainScreens/router.dart';
import 'mainScreens/splashscreen.dart';

void main() => runApp(ChangeNotifierProvider<ValueNotifier<bool>>(
    create: (context) => ValueNotifier(false),
    child: Consumer<ValueNotifier<bool>>(
      builder: (_, notifier, __) => MaterialApp(
        onGenerateRoute: createRoute,
        title: 'Schoo-Lah',
        debugShowCheckedModeBanner: false,
        theme: notifier.value
            ? ThemeData(primarySwatch: Colors.yellow)
            : ThemeData(primarySwatch: Colors.orange),
        home: SchoolahSplashScreen(),
      ),
    )));
