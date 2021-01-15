import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/todo.dart';
import 'package:schoolah_mobile_app/services/todo_data_service.dart';

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
    final TodoDataService todoDataService = service();

    return FutureBuilder<List<Todo>>(
        future: todoDataService.getTodoList(),
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
      appBar: AppBar(
        // leading: Container(),
        title: Text('QR CODE GENERATOR'),
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
          child: Column(children: [
            SizedBox(height: 80.0),
            Text('Subject',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            DropdownButton<String>(
              items: <String>[
                'Choose Subject',
                'Mathematic',
                'Science',
                'Bahasa Melayu',
                'English',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ); //DropMenuItem
              }).toList(),
              value: dropdownValue,
              onChanged: (String newValue) {
                setState(() {
                  dropdownValue = newValue;
                  print("new${newValue}");
                }); //setState
              },
              //OnChange
              isExpanded: false,
              hint: Text(
                'Choose subject',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 31.0),
            Text('Year',
                style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 20.0),
            DropdownButton<String>(
              items: <String>[
                'Select Year',
                'Year 1',
                'Year 2',
                'Year 3',
                'Year 4',
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
                }); //setState
              },
              //OnChange
              isExpanded: false,
              hint: Text(
                'Select Year',
                style: TextStyle(color: Colors.black),
              ),
            ),
            SizedBox(height: 20.0),
            FloatingActionButton.extended(
              heroTag: null,
              onPressed: () {
                Navigator.pushNamed(context, QRcode);
              },
              label: Text('   GENERATE   ',
                  style:
                      TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
            ),
          ]),
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
