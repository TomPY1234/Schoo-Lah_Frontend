import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';

class TeacherDrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final changeModeNotifier = Provider.of<ValueNotifier<bool>>(context);

    return Drawer(
      child: DrawerHeader(
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text('Menu',
                  style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w600,
                      fontSize: 30,
                      color: Colors.black)),
              tileColor: Theme.of(context).accentColor,
            ),
            CheckboxListTile(
              title: Text('Change Theme Color',
                  style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              subtitle: changeModeNotifier.value
                  ? Text('Dark Mode')
                  : Text('Light Mode'),
              value: changeModeNotifier.value,
              onChanged: (newValue) => changeModeNotifier.value = newValue,
            ),
            ListTile(
              title: Text('Subjects',
                  style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              onTap: () {
                Navigator.pushNamed(context, teacherSubject);
              },
              trailing: Image.asset('assets/study.png', height: 30),
            ),
            ListTile(
              title: Text('Students',
                  style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              onTap: () {
                Navigator.pushNamed(context, '/teacherstudentlist');
              },
              trailing: Image.asset('assets/student.jpg', height: 24),
            ),
            ListTile(
              title: Text('QR History',
                  style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              onTap: () {
                Navigator.pushNamed(context, teachQR);
              },
              trailing: Image.asset('assets/qrcode.png', height: 30),
            ),
            ListTile(
              title: Text('My Profile',
                  style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              onTap: () {
                Navigator.pushNamed(context, teachProfile);
              },
              trailing: Icon(Icons.account_circle_rounded, size: 30),
            ),
            ListTile(
              title: Text('Logout',
                  style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              onTap: () {
                Navigator.pushNamed(context, '/login');
              },
              trailing: Icon(Icons.logout),
            ),
          ],
        ),
        decoration: BoxDecoration(color: Theme.of(context).accentColor),
      ),
    );
  }
}
