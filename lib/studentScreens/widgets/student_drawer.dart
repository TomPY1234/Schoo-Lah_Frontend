import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';

class DrawerView extends StatelessWidget {
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
                Navigator.pushNamed(context, studSubject);
              },
              trailing: Image.asset('assets/study.png', height: 30),
            ),
            ListTile(
              title: Text('Financial',
                  style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              onTap: () {
                Navigator.pushNamed(context, studFee);
              },
              trailing: Image.asset('assets/financial.png', height: 30),
            ),
            ListTile(
              title: Text('E-Bookstore',
                  style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              onTap: () {
                Navigator.pushNamed(context, studBook);
              },
              trailing: Image.asset('assets/ebook.png', height: 30),
            ),
            ListTile(
              title: Text('QR Scan',
                  style: TextStyle(
                      fontFamily: "pop",
                      fontWeight: FontWeight.w600,
                      color: Colors.black)),
              onTap: () {
                Navigator.pushNamed(context, QRStudentcode);
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
                Navigator.pushNamed(context, studProfile);
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
