import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/user.dart';
import 'package:schoolah_mobile_app/services/user_data_service.dart';

import '../dependencies.dart';

class TeacherProfileScreen extends StatefulWidget {
  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfileScreen> {
  User user;
  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 1) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, '/teacherhome');
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, '/teacherprofile');
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserDataService userDataService = service();

    return FutureBuilder<User>(
        future: userDataService.getCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            user = snapshot.data;
            return _buildMainScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildMainScreen() {
    final changeModeNotifier = Provider.of<ValueNotifier<bool>>(context);
    String name;
    String phone;
    String email;
    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        //leading: Icon(Icons.settings, size: 40.0),
        title: Text('MY PROFILE'),
        centerTitle: true,
        actions: <Widget>[
          Icon(Icons.calendar_today_rounded, size: 35.0),
          SizedBox(width: 12.0)
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.orange[200],
              Colors.orange[50],
              Colors.orange[200],
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                      height: 150.0,
                      child: Icon(
                        Icons.supervised_user_circle_rounded,
                        size: 150.0,
                      )),
                  Text('NAME',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold)),
                  TextField(
                    onChanged: (value) => name = value,
                    obscureText: false,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: user.name,
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text('EMAIL',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold)),
                  TextField(
                    onChanged: (value) => email = value,
                    obscureText: false,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: user.email,
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text('CONTACT NO.',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold)),
                  TextField(
                    onChanged: (value) => phone = value,
                    obscureText: false,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: user.phone,
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  FloatingActionButton.extended(
                    heroTag: null,
                    onPressed: () {
                      UserDataService userDataService = service();
                      userDataService.updateDetails(
                          name: name, email: email, phone: phone);
                      Navigator.pushNamed(context, teachHome);
                    },
                    label: Text('   UPDATE   ',
                        style: TextStyle(
                            fontSize: 19.0, fontWeight: FontWeight.bold)),
                  ),
                  SizedBox(height: 15.0),
                  FloatingActionButton.extended(
                    heroTag: null,
                    backgroundColor: Colors.red,
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    label: Text('   LOG OUT   ',
                        style: TextStyle(
                            fontSize: 19.0, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'QRHISTORY',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: DrawerHeader(
          child: CheckboxListTile(
            title: Text('Change theme color'),
            value: changeModeNotifier.value,
            onChanged: (newValue) => changeModeNotifier.value = newValue,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange[200],
                Colors.orange[50],
                Colors.orange[200],
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching current user... Please wait'),
          ],
        ),
      ),
    );
  }
}
