import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mainScreens/router.dart';
import 'mainScreens/splashscreen.dart';
import 'dependencies.dart' as di;

void main() {
  di.init();
  runApp(ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (context) => ValueNotifier(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, notifier, __) => MaterialApp(
          onGenerateRoute: createRoute,
          title: 'Schoo-Lah',
          debugShowCheckedModeBanner: false,
          theme: notifier.value
              ? ThemeData(
                primarySwatch: Colors.pink,
                primaryColor: Color(0XFFFF99DD),
                accentColor: Color(0XFFFFE6F7),
                primaryColorLight: Color(0XFFFF33BB),
                )
              : ThemeData(
                primarySwatch: Colors.orange,
                primaryColor: Color(0XFFFFD1B3),
                accentColor: Color(0XFFFFF0E6),
                primaryColorLight: Color(0XFFFF8533),
                ),
          home: SchoolahSplashScreen(),
        ),
      )));
}
