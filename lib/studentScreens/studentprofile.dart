import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schoolah_mobile_app/mainScreens/constants.dart';
import 'package:schoolah_mobile_app/models/user.dart';
import 'package:schoolah_mobile_app/services/user_service_rest.dart';

class StudentProfileScreen extends StatefulWidget {
  @override
  _StudentProfileState createState() => _StudentProfileState();
}

String name;
String phone;
String email;
String school;
int year;
User user;

class _StudentProfileState extends State<StudentProfileScreen> {
  int _selectedIndex = 2;

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
    final dataService = UserServiceRest();

    return FutureBuilder<User>(
        future: dataService.getCurrentUser(),
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
      backgroundColor: Theme.of(context).accentColor,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              floating: true,
              elevation: 0,
              snap: true,
              backgroundColor: Theme.of(context).primaryColorDark,
              brightness: Brightness.light,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined),
                onPressed: () => Navigator.pushNamed(context, studHome),
              ),
            ),
          ];
        },
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Theme.of(context).accentColor, Theme.of(context).primaryColorDark],
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
                              color: Colors.cyan.withOpacity(0.4),
                              blurRadius: 10,
                              offset: Offset(0.0, 6),
                            ),
                          ],
                          color: Colors.cyan,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                      child: Icon(Icons.add_a_photo,
                                          color: Colors.white),
                                      decoration: BoxDecoration(
                                          color: Colors.deepOrange,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20))),
                                    ),
                                  )
                                ],
                              ),

                              SizedBox(width: 10),

                              Image.asset('assets/profile.png', height: 120),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: 'My ',
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColorLight,
                                )),
                            TextSpan(
                                text: 'Profile',
                                style: TextStyle(
                                  fontFamily: "pop",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 25,
                                  color: Theme.of(context).primaryColor,
                                )),
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
                displayProfileString(
                    user.name, Icons.account_circle_rounded, name),
                displayProfileInt(
                    user.year, Icons.confirmation_number_outlined),
                displayProfileString(
                    user.phone, Icons.phone_android_outlined, phone),
                displayProfileString(user.email, Icons.email_outlined, email),
                displayProfileString(
                    user.school, Icons.school_outlined, school),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton.icon(
                      onPressed: () async {
                        final dataService = UserServiceRest();
                        final newuser = await dataService.updateDetails(
                            name: name,
                            year: year,
                            school: school,
                            email: email,
                            phone: phone,
                            id: user.id);
                        dataService.setCurrentUser(curruser: newuser);
                        Navigator.pushNamed(context, studHome);
                      },
                      icon: Icon(Icons.update_outlined, size: 18),
                      label: Text("Save Changes",
                          style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.white)),
                    ),
                    SizedBox(width: 30),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      icon: Icon(Icons.logout, size: 18),
                      label: Text("Log Out",
                          style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 18,
                              color: Colors.white)),
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
                subtitle:
                    changeModeNotifier.value ? Text('Dark Mode') : Text('Light Mode'),
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

displayProfileString(
    String valueString, IconData valueIcon, String valueChanged) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.4),
            blurRadius: 10,
            offset: Offset(0.0, 6),
          ),
        ],
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Icon(valueIcon, size: 50),
                    decoration: BoxDecoration(
                        color: Colors.cyanAccent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        )),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            onChanged: (value) {
                              if (valueString == user.name) {
                                valueChanged = value;
                                name = valueChanged;
                              }
                              if (valueString == user.phone) {
                                valueChanged = value;
                                phone = valueChanged;
                              }
                              if (valueString == user.school) {
                                valueChanged = value;
                                school = valueChanged;
                              }
                              if (valueString == user.email) {
                                valueChanged = value;
                                email = valueChanged;
                              }
                            },
                            obscureText: false,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: valueString,
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
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
  );
}

displayProfileInt(int valueInt, IconData valueIcon) {
  return Padding(
    padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
    child: Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withOpacity(0.4),
            blurRadius: 10,
            offset: Offset(0.0, 6),
          ),
        ],
        color: Colors.cyan,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.center,
                    child: Icon(valueIcon, size: 50),
                    decoration: BoxDecoration(
                        color: Colors.cyanAccent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40),
                          bottomLeft: Radius.circular(10),
                          topLeft: Radius.circular(10),
                        )),
                  ),
                ),
                Flexible(
                  flex: 4,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextField(
                            onChanged: (value) => year = int.parse(value),
                            obscureText: false,
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              hintText: valueInt.toString(),
                              fillColor: Colors.white,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(32.0)),
                            ),
                          ),
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
  );
}
