import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/user.dart';
import 'package:schoolah_mobile_app/services/user_data_service.dart';

import '../dependencies.dart';

class StudentProfileScreen extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

class _StudentProfileState extends State<StudentProfileScreen> {
  User user;
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, QRStudentcode);
    } else if (index == 1) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, studHome);
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, studProfile);
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
    String name;
    String phone;
    String email;
    String school;
    int year;
    final changeModeNotifier = Provider.of<ValueNotifier<bool>>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 Stack(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 70,
                        backgroundImage: NetworkImage('https://randomuser.me/api/portraits/thumb/men/86.jpg'),
                      ),
                      Positioned(
                        bottom: 1, 
                        right: 1,
                        child: Container(
                          height: 40,
                          width: 40,
                          child: Icon(Icons.add_a_photo, color: Colors.white),
                          decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.all(Radius.circular(20))),
                        ),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15)),
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
                  Text('YEAR',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold)),
                  TextField(
                    onChanged: (value) => year = int.parse(value),
                    obscureText: false,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: user.year.toString(),
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding:
                          EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(32.0)),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  Text('SCHOOL STUDIED',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold)),
                  TextField(
                    onChanged: (value) => school = value,
                    obscureText: false,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      hintText: user.school,
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
                  Text('EMAIL',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold)),
                  TextField(
                    obscureText: false,
                    onChanged: (value) => email = value,
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
                  FloatingActionButton.extended(
                    backgroundColor: Theme.of(context).primaryColorLight,
                    heroTag: null,
                    onPressed: () {
                      UserDataService userDataService = service();
                      userDataService.updateDetails(
                          name: name,
                          year: year,
                          school: school,
                          email: email,
                          phone: phone);
                      Navigator.pushNamed(context, studHome);
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'QRScan',
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
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: DrawerHeader(
          child: CheckboxListTile(
            title: Text('Change Theme Color'),
            value: changeModeNotifier.value,
            onChanged: (newValue) => changeModeNotifier.value = newValue,
          ),
          decoration: BoxDecoration(color: Theme.of(context).primaryColor),
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
