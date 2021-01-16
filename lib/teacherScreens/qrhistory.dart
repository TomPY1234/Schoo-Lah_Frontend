import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

class _ScanState extends State<ScanScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, teachQR);
    } else if (index == 1) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, teachHome);
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, teachProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    final changeModeNotifier = Provider.of<ValueNotifier<bool>>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text('QR Generator', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back), 
            onPressed: () => Navigator.pushNamed(context, teachHome),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Please Scan the QR Code for Attendance', textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              Padding(padding: EdgeInsets.only(top: 10)),
              SizedBox(
                child: Image.asset(
                  'assets/qr.jpeg',
                ),
              ),
            ],
          ),
        ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
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
}
