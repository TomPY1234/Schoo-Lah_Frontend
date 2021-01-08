import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './studentScreens/bookstore.dart';
import 'mainScreens/login.dart';
import 'mainScreens/router.dart';

void main() => runApp(ChangeNotifierProvider<ValueNotifier<bool>>(
    create: (context) => ValueNotifier(false),
    child: Consumer<ValueNotifier<bool>>(
      builder: (_, notifier, __) => MaterialApp(
        onGenerateRoute: createRoute,
        title: 'Schoo-Lah',
        debugShowCheckedModeBanner: false,
        theme: notifier.value
            ? ThemeData.dark()
            : ThemeData(primarySwatch: Colors.orange),
        home: LoginPageScreen(),
      ),
    )));
