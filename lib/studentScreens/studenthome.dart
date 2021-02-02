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
                      Text('Hello,', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w300, fontSize: 28, color: Colors.black)),
                      
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Text('${user.name}', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w700, fontSize: 30, color: Colors.black)),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: homeCategoryItem(
                                    context,
                                    Colors.green,
                                    'assets/study.png', 
                                    'Subjects',
                                    Colors.greenAccent,
                                    'Subjects'
                                  ),
                                ),
                              ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: homeCategoryItem(
                                  context,
                                  Colors.purple,
                                  'assets/financial.png', 
                                  'Financial',
                                  Colors.purpleAccent,
                                  'Financial'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 7),
                                child: homeCategoryItem(
                                  context,
                                  Colors.lime,
                                  'assets/ebook.png',
                                  'E-Bookstore',
                                  Colors.limeAccent,
                                  'E-Bookstore'
                                ),
                              ),
                            ),

                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(left: 7),
                                child: homeCategoryItem(
                                  context,
                                  Colors.orange,
                                  'assets/qrcode.png',
                                  'QR Scan',
                                  Colors.red,
                                  'QR Scan'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 10),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(text: 'Popular ', style: TextStyle(
                              fontFamily: "pop",
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                              color: Colors.black,
                            )),

                            TextSpan(text: 'Subjects', style: TextStyle(
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

                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      horizontalScrollCourseItem(context, 'assets/SCIENCE.png', 'Science', 'Intresting in Science in Real Life'),

                      horizontalScrollCourseItem(context, 'assets/BAHASA MALAYSIA.png', 'Bahasa Melayu', 'Memahami Bahasa Kebangsaan Kita'),

                      horizontalScrollCourseItem(context, 'assets/MATHEMATICS.png', 'Mathematics', 'Calculation and Mathematics Logic'),

                      SizedBox(width: 16),
                    ],
                  ),
                ),
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
                onTap: () { Navigator.pushNamed(context, studSubject); },
                trailing: Image.asset('assets/study.png', height: 30),
              ),

              ListTile(
                title: Text('Financial', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, studFee); },
                trailing: Image.asset('assets/financial.png', height: 30),
              ),

              ListTile(
                title: Text('E-Bookstore', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, studBook); },
                trailing: Image.asset('assets/ebook.png', height: 30),
              ),

              ListTile(
                title: Text('QR Scan', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, QRStudentcode); },
                trailing: Image.asset('assets/qrcode.png', height: 30),
              ),

              ListTile(
                title: Text('My Profile', style: TextStyle(fontFamily: "pop", fontWeight: FontWeight.w600, color: Colors.black)),
                onTap: () { Navigator.pushNamed(context, studProfile); },
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
            Text('Fetching current user... Please wait'),
          ],
        ),
      ),
    );
  }
}

//---------------------------------------------------------------------------------------
Widget homeCategoryItem(BuildContext context, Color primaryColor, String primaryIcon, String primaryTitle, Color secondaryColor, String dashboard)
{
  return Container(
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: primaryColor.withOpacity(0.4),
        blurRadius: 10,
        offset: Offset(0.0, 6),
      ),
    ],
    color: primaryColor,
    borderRadius: BorderRadius.circular(10),
    ),
    child: Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: () {
          if (dashboard == 'Subjects')
          { Navigator.pushNamed(context, studSubject); }
          else if (dashboard == 'Financial')
          { Navigator.pushNamed(context, studFee); }
          else if (dashboard == 'E-Bookstore')
          { Navigator.pushNamed(context, studBook); }
          else 
          { Navigator.pushNamed(context, QRStudentcode); }
        },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(primaryIcon, height: 45),
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(primaryTitle, style: TextStyle(
                            fontFamily: "pop",
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  alignment: Alignment.center,
                  child: Icon(Icons.arrow_forward_ios_outlined),
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(40),
                      topLeft: Radius.circular(40),
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget horizontalScrollCourseItem(BuildContext context, String courseImage, String courseTitle, String courseDesc)
{
  return Padding(
    padding: const EdgeInsets.only(left: 16),
    child: Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Flexible(
              flex: 3,
              child: Container(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Image.asset(courseImage),
              ),
            ),

            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(courseTitle+'\n~ '+courseDesc, style: TextStyle(
                  fontFamily: "pop",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Colors.deepPurple
                )
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}