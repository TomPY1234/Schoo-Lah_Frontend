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
              ? ThemeData(primarySwatch: Colors.pink)
              : ThemeData(primarySwatch: Colors.orange),
          home: SchoolahSplashScreen(),
        ),
      )));
}
