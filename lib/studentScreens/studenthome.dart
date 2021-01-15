import 'package:flutter/material.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/services/user_data_service.dart';
import '../dependencies.dart';
import '../models/user.dart';
import 'package:provider/provider.dart';

class StudentHomePageScreen extends StatefulWidget {
  //User currUser;
  //StudentHomePageScreen(this.currUser);
  @override
  _StudentHomePageState createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePageScreen> {
  User user;
  int _selectedIndex = 1;
  //_StudentHomePageState(this.user);

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
                  Navigator.pushNamed(context, studSubject);
                },
                label: Text('My Subjects',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                icon: Icon(Icons.book_rounded),
              ),
              SizedBox(height: 30.0),
              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  Navigator.pushNamed(context, studFee);
                },
                label: Text('Tuition Fee  ',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                icon: Icon(Icons.attach_money_rounded),
              ),
              SizedBox(height: 30.0),
              FloatingActionButton.extended(
                heroTag: null,
                onPressed: () {
                  Navigator.pushNamed(context, studBook);
                },
                label: Text('E-Bookstore ',
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
