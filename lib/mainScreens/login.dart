import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/services/user_service_rest.dart';
import 'package:schoolah_mobile_app/teacherScreens/teacherhome.dart';
import '../studentScreens/studenthome.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';

class LoginPageScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageScreen> {
  String username;
  String password;
  bool newValue = false;
  final dataService = UserServiceRest();

  @override
  Widget build(BuildContext context) {
    final changeModeNotifier = Provider.of<ValueNotifier<bool>>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              floating: true,
              elevation: 0,
              snap: true,
              backgroundColor: Theme.of(context).primaryColorDark,
              brightness: Brightness.light,
              leading: Container(
                  decoration:
                      BoxDecoration(color: Theme.of(context).primaryColorDark)),
              actions: <Widget>[
                RaisedButton.icon(
                  onPressed: () {
                    if (newValue == true) {
                      newValue = false;
                    } else {
                      newValue = true;
                    }
                    setState(() {
                      changeModeNotifier.value = newValue;
                    });
                  },
                  icon: Icon(Icons.lightbulb_outline,
                      color: changeModeNotifier.value
                          ? Colors.white
                          : Colors.black),
                  label: changeModeNotifier.value
                      ? Text('Dark', style: TextStyle(color: Colors.white))
                      : Text('Light', style: TextStyle(color: Colors.black)),
                  color: Theme.of(context).primaryColorDark,
                ),
              ],
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Theme.of(context).accentColor,
                Theme.of(context).primaryColorDark
              ],
            ),
          ),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.4),
                          blurRadius: 10,
                          offset: Offset(0.0, 6),
                        ),
                      ],
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 530,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child:
                                      Image.asset('assets/schoolah_logo.png'),
                                ),
                              ),
                              Flexible(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 20),
                                        child: Text('LOGIN',
                                            style: TextStyle(
                                              fontFamily: "pop",
                                              fontWeight: FontWeight.w700,
                                              fontSize: 30,
                                              color: Colors.white,
                                            )),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 30),
                                        child: TextField(
                                          obscureText: false,
                                          onChanged: (value) =>
                                              username = value,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Username',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32.0)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 20),
                                        child: TextField(
                                          obscureText: true,
                                          onChanged: (value) =>
                                              password = value,
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Password',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 10.0, 20.0, 10.0),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        32.0)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 30),
                                        child: FloatingActionButton.extended(
                                          backgroundColor: Colors.deepOrange,
                                          heroTag: null,
                                          onPressed: () async {
                                            final User success =
                                                await dataService.login(
                                                    username, password);
                                            if (success == null) {
                                              showAlertDialog(context);
                                            } else if (success.type ==
                                                'teacher') {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return TeacherHomePageScreen(); //teacherhome
                                              }));
                                            } else if (success.type ==
                                                'student') {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return StudentHomePageScreen();
                                              }));
                                            }
                                          },
                                          label: Text('Login Now',
                                              style: TextStyle(
                                                fontFamily: "pop",
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20,
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10, top: 30),
                                        child: TextButton(
                                            child: Text(
                                                'First Time User? Sign Up Now!',
                                                style: TextStyle(
                                                  fontFamily: "pop",
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                )),
                                            onPressed: () {
                                              Navigator.pushNamed(
                                                  context, '/studentSignup');
                                            }),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.brown,
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(40),
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(40),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('© SCHOO-LAH @ By Team Exia',
                        style: TextStyle(
                          fontFamily: "pop",
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.black,
                        )),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Login Failed',
              style: TextStyle(
                fontFamily: "pop",
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: Colors.orange,
              )),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Please enter a valid username and password.',
                    style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Retry',
                  style: TextStyle(
                    fontFamily: "pop",
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.redAccent,
                  )),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginPageScreen();
                }));
              },
            ),
          ],
        );
      },
    );
  }
}
