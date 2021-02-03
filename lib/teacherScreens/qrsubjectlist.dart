import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/todo.dart';
import 'package:schoolah_mobile_app/services/todo_service_rest.dart';

import '../dependencies.dart';

class DetailsScreen extends StatefulWidget {
  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
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
  String dropdownValue = 'Choose Subject';
  String dropdownValue1 = 'Select Year';

  Widget build(BuildContext context) {
    final dataService = TodoServiceRest();

    return FutureBuilder<List<Todo>>(
        future: dataService.getAllTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return _buildMainScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildMainScreen() {
    final changeModeNotifier = Provider.of<ValueNotifier<bool>>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: AppBar(
        title: Text('QR Generator',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
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
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 15)),
            Image.asset('assets/QRSCAN.png', width: 100.0, height: 100.0),
            Divider(color: Colors.grey[300], height: 25),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text('Subject',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              items: <String>[
                'Choose Subject',
                'Mathematics',
                'Science',
                'Bahasa Malaysia',
                'English',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                  print("new${newValue}");
                });
              },
              isExpanded: true,
              hint:
                  Text('Choose Subject', style: TextStyle(color: Colors.black)),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text('Year',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              items: <String>[
                'Select Year',
                'Year 1',
                'Year 2',
                'Year 3',
                'Year 4',
                'Year 5',
                'Year 6',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ); //DropMenuItem
              }).toList(),
              value: dropdownValue1,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue1 = newValue;
                  print("new${newValue}");
                });
              },
              isExpanded: true,
              hint: Text('Select Year', style: TextStyle(color: Colors.black)),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            FloatingActionButton.extended(
              backgroundColor: Theme.of(context).primaryColorLight,
              heroTag: null,
              onPressed: () {
                Navigator.pushNamed(context, QRcode);
              },
              label: Text('GENERATE',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
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

  Scaffold _buildFetchingDataScreen() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            SizedBox(height: 50),
            Text('Fetching todo... Please wait'),
          ],
        ),
      ),
    );
  }
}
