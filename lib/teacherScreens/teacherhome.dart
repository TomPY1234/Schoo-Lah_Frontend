import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';

class TeacherHomePageScreen extends StatefulWidget {
  User currUser;
  TeacherHomePageScreen(this.currUser);
  @override
  _TeacherHomePageState createState() => _TeacherHomePageState(currUser);
}

class _TeacherHomePageState extends State<TeacherHomePageScreen> {
  final User user;
  int _selectedIndex = 1;
  _TeacherHomePageState(this.user);

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, '/qrsubjectlist');
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
    final changeModeNotifier = Provider.of<ValueNotifier<bool>>(context);

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        //leading: Icon(Icons.settings, size: 40.0),
        title: Text('HI, ${user.name}'),
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 220.0,
                child: Image.asset(
                  'assets/schoolah_logo.png',
                  width: 200.0,
                  height: 200.0,
                ),
              ),
              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  Navigator.pushNamed(context, '/teachersubjectlist');
                },
                label: Text('My Subjects',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                icon: Icon(Icons.book_rounded),
              ),
              SizedBox(height: 30.0),
              // FloatingActionButton.extended(
              //   heroTag: null,
              //   onPressed: () {
              //     Navigator.pushNamed(context, studFee);
              //   },
              //   label: Text('Student List',
              //       style:
              //           TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              //   icon: Icon(Icons.attach_money_rounded),
              // ),
              // SizedBox(height: 30.0),
              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  Navigator.pushNamed(context, '/teacherstudentlist');
                },
                label: Text('Student List',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                icon: Icon(Icons.store_rounded),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner_rounded),
            label: 'QRGenerator',
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
}
