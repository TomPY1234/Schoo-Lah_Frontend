import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/qrcode.dart';
import 'package:schoolah_mobile_app/services/qrcode_data_service.dart';

import '../dependencies.dart';

class ScanZoneScreen extends StatefulWidget {
  @override
  _ScanZoneState createState() => _ScanZoneState();
}

class _ScanZoneState extends State<ScanZoneScreen> {
  int _selectedIndex = 0;

  List<QRCode> scanCode;

  void _onItemTapped(int index) {
    if (index == 0) {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pushNamed(context, '/login');
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
    final QRCodeDataService qrcodeDataService = service();

    return FutureBuilder<List<QRCode>>(
        future: qrcodeDataService.getAllHistory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            scanCode = snapshot.data;
            return _buildMainScreen();
          }
          return _buildFetchingDataScreen();
        });
  }

  Scaffold _buildMainScreen() {
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
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: () { Navigator.pushNamed(context, teachHome); }
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Theme.of(context).accentColor, Colors.white],
            ),
          ),
          child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0.0, 6),
                            ),
                          ],
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('${scanCode.last.subject}\nYear ${scanCode.last.year}\n\nClass Date Time : \n${scanCode.last.classTime}', style: TextStyle(
                                fontFamily: "pop",
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white
                              )),

                              SizedBox(width: 20),

                              Image.asset('assets/qrscancode.png', height: 100),
                            ],
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(text: 'Scan ', style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Colors.black,
                            )),

                            TextSpan(text: 'QR Attendance', style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Colors.orange,
                            )),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.blueGrey.withOpacity(0.4),
                        blurRadius: 10,
                        offset: Offset(0.0, 6),
                      ),
                    ],
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(10),
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          height: 400,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Flexible(
                                flex: 4,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(left: 10, right: 10),
                                        child: Image.asset('assets/qr.jpeg'),
                                      ),
                                    ],
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
                    ElevatedButton.icon(
                      onPressed: () { Navigator.pushNamed(context, teachQR); },
                      icon: Icon(Icons.arrow_back_ios_outlined, size: 18),
                      label: Text("Back" , style: TextStyle(
                        fontFamily: "pop",
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.white)
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).accentColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
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
        selectedFontSize: 12,
        onTap: _onItemTapped,
      ),

      endDrawer: Drawer(
        child: DrawerHeader(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text('Menu', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, fontSize: 30, color: Colors.black)),
                tileColor: Theme.of(context).accentColor,
              ),

              CheckboxListTile(
                title: Text('Change Theme Color', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                subtitle: changeModeNotifier.value ? Text('Pink') : Text('Orange'),
                value: changeModeNotifier.value,
                onChanged: (newValue) => changeModeNotifier.value = newValue,
              ),

              ListTile(
                title: Text('Subjects', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, teacherSubject); },
                trailing: Image.asset('assets/study.png', height: 30),
              ),

              ListTile(
                title: Text('Students', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, '/teacherstudentlist'); },
                trailing: Image.asset('assets/student.jpg', height: 24),
              ),

              ListTile(
                title: Text('QR History', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, teachQR); },
                trailing: Image.asset('assets/qrcode.png', height: 30),
              ),

              ListTile(
                title: Text('My Profile', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, teachProfile); },
                trailing: Icon(Icons.account_circle_rounded, size: 30),
              ),

              ListTile(
                title: Text('Logout', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, '/login'); },
                trailing: Icon(Icons.logout),
              ),
            ],
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
            Text('Generating QR Code... Please wait'),
          ],
        ),
      ),
    );
  }
}
