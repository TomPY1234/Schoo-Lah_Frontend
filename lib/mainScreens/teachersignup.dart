import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/services/user_service_rest.dart';
import 'package:provider/provider.dart';

class TeacherSignupPageScreen extends StatefulWidget {
  @override
  TeacherSignupPageState createState() => TeacherSignupPageState();
}

class TeacherSignupPageState extends State<TeacherSignupPageScreen> {
  String username;
  String password;
  String name;
  String phone;
  String email;
  String _value = 'teacher';
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
              leading: Container(decoration: BoxDecoration(color: Theme.of(context).primaryColorDark)),
              actions: <Widget>[
                RaisedButton.icon(
                  onPressed: () {
                    if (newValue == true )
                    { newValue = false; }
                    else 
                    { newValue = true; }
                    setState(() { changeModeNotifier.value = newValue; });
                  },
                  icon: Icon(Icons.lightbulb_outline, color: changeModeNotifier.value ? Colors.white : Colors.black), 
                  label: changeModeNotifier.value ? Text('Dark', style: TextStyle(color: Colors.white)) : Text('Light', style: TextStyle(color: Colors.black)), 
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
              colors: [Theme.of(context).accentColor, Theme.of(context).primaryColorDark],
            ),
          ),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(0.4),
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
                          height: 850,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Flexible(
                                flex: 1,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Image.asset('assets/schoolah_logo.png'),
                                ),
                              ),

                              Flexible(
                                flex: 5,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 20),
                                        child: Text('SIGN UP', style: TextStyle(
                                          fontFamily: "pop",
                                          fontWeight: FontWeight.w700,
                                          fontSize: 30,
                                          color: Colors.white,
                                        )),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                                        child: Container(
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(50)),
                                          child: Padding(
                                            padding: EdgeInsets.only(top: 5, left: 20, right: 20),
                                            child: DropdownButton(
                                              value: _value,
                                              underline: Container(
                                                height: 2,
                                                color: Colors.white,
                                              ),
                                              iconSize: 30,
                                              items: [
                                                DropdownMenuItem(
                                                  child: Text('Student', style: TextStyle(
                                                    fontFamily: "pop",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  )), 
                                                  value: 'student'
                                                ),
                                                DropdownMenuItem(
                                                  child: Text('Teacher', style: TextStyle(
                                                    fontFamily: "pop",
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                  )), 
                                                  value: 'teacher'
                                                ),
                                              ],
                                              isExpanded: true,
                                              onChanged: (value) {
                                                setState(() { _value = value; });
                                                if (_value == 'student') { Navigator.pushNamed(context, '/studentSignup'); }
                                              }
                                            ),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                                        child: TextField(
                                          obscureText: false,
                                          onChanged: (value) => name = value,
                                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Name',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                                        child: TextField(
                                          obscureText: false,
                                          onChanged: (value) => email = value,
                                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Email',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                                        child: TextField(
                                          obscureText: false,
                                          onChanged: (value) => phone = value,
                                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Contact Number',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                                        child: TextField(
                                          obscureText: false,
                                          onChanged: (value) => username = value,
                                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Username',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                                        child: TextField(
                                          obscureText: true,
                                          onChanged: (value) => password = value,
                                          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                                          decoration: InputDecoration(
                                            hintText: 'Enter Password',
                                            fillColor: Colors.white,
                                            filled: true,
                                            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                          ),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                                        child: FloatingActionButton.extended(
                                          backgroundColor: Colors.deepOrange,
                                          heroTag: null,
                                          onPressed: () {
                                            dataService.registerNew(
                                                username: username,
                                                password: password,
                                                name: name,
                                                year: null,
                                                school: null,
                                                email: email,
                                                type: _value,
                                                phone: phone);
                                            Navigator.pushNamed(context, '/login');
                                          },
                                          label: Text('SignUp Now', style: TextStyle(
                                            fontFamily: "pop",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 20,
                                            color: Colors.white,
                                          )),
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10, top: 30),
                                        child: TextButton(
                                          child: Text('Already Sign Up? Log In Now!', style: TextStyle(
                                            fontFamily: "pop",
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                            color: Colors.white,
                                          )),
                                          onPressed: () { Navigator.pushNamed(context, '/login'); }
                                        ),
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
                                    )
                                  ),
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
                    Text('© SCHOO-LAH @ By Team Exia', style: TextStyle(
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
}
